//
//  AuthService.m
//  Sconit
//
//  Created by tony on 15/12/17.
//  Copyright © 2015年 tony. All rights reserved.
//

#import "AuthService.h"
#import "AppConfig.h"
#import "YYModel.h"

static NSString * const kClientID           = @"eb6250c28c0a691aab3828b79e4b63c65fa16e5f16ae754cde2cf8aacca5bac0";
static NSString * const kClientSecret       = @"74434359b3f676f1807fc50cd320953650780e47bb8e3e9e14a951992962c406";
static NSString * const kClientIdentifier   = @"AuthCredentialIdentifier";

@implementation AuthService

+ (instancetype)shareAuthService
{
    static AuthService *_shareAPIService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareAPIService = [[AuthService alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString] clientID:kClientID secret:kClientSecret];
    });
    
    return _shareAPIService;
}

- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
                  success:(void (^)(AFOAuthCredential *credential))success
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [self loginWithUsername:username
                   password:password
                     params:nil success:success
                    failure:failure];
}


- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
                   params:(NSDictionary *)params
                  success:(void (^)(AFOAuthCredential *credential))success
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSString *urlString = [[NSMutableString alloc] initWithString:@"/token"];
    if (params) {
        for (int i = 0; i < params.count; i++) {
            if (i == 0) {
                urlString = [urlString stringByAppendingFormat:@"?%@=%@", params.allKeys[i], params.allValues[i]];
            }
            else {
                urlString = [urlString stringByAppendingFormat:@"&%@=%@", params.allKeys[i], params.allValues[i]];
            }
        }
    }
    
    [self authenticateUsingOAuthWithURLString:urlString
                                     username:username
                                     password:password scope:@"" success:^(AFOAuthCredential *credential) {
                                         [self storeCredential:credential withIdentifier:kClientIdentifier];
                                         if (success != nil) {
                                             success(credential);
                                         }
                                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         if (failure != nil) {
                                             failure(operation, error);
                                             return;
                                         }
                                     }];
}

- (void)refreshTokenWithSuccess:(void (^)(AFOAuthCredential *newCredential))success
                        failure:(void (^)(NSError *error))failure
{
    NSLog(@"refreshTokenWithSuccess");
    
    AFOAuthCredential *credential = [self retrieveCredential];
    if (credential == nil) {
        NSLog(@"refreshTokenWithSuccess: credential is nil");
        if (failure) {
            NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
            [errorDetail setValue:@"Failed to get credentials" forKey:NSLocalizedDescriptionKey];
            NSError *error = [NSError errorWithDomain:@"world" code:200 userInfo:errorDetail];
            failure(error);
        }
        return;
    }
    
    NSLog(@"refreshTokenWithSuccess refreshToken: %@", credential.refreshToken);
    [self authenticateUsingOAuthWithURLString:@"/token"
                                 refreshToken:credential.refreshToken
                                      success:^(AFOAuthCredential *newCredential) {
                                          NSLog(@"refreshTokenWithSuccess refreshed access token: %@", newCredential.accessToken);
                                          [self storeCredential:newCredential withIdentifier:kClientIdentifier];
                                          if (success != nil) {
                                              success(newCredential);
                                          }
                                      } failure:^(__unused AFHTTPRequestOperation *operation, NSError *error) {
                                          NSLog(@"refreshTokenWithSuccess: an error occurred refreshing credential: %@", error);
                                          if (failure != nil) {
                                              failure(error);
                                          }
                                      }];
}

- (void)signOut {
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kClientIdentifier];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (bool)isSignIn {
    AFOAuthCredential *credential = [self retrieveCredential];
    if (credential == nil) {
        return false;
    }
    
    return true;
}

- (AFOAuthCredential *)retrieveCredential
{
    if([[NSUserDefaults standardUserDefaults] objectForKey:kClientIdentifier] != nil){
        NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:kClientIdentifier];
        return [AFOAuthCredential yy_modelWithJSON:dict];
    }
    return nil;
}

- (BOOL)storeCredential:(AFOAuthCredential *)credential withIdentifier:(NSString *)identifier
{
    NSDictionary *dict = [credential yy_modelToJSONObject];
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:kClientIdentifier];
    return [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
