//
//  AuthService.h
//  Sconit
//
//  Created by tony on 15/12/17.
//  Copyright © 2015年 tony. All rights reserved.
//

#import "AFOAuth2Manager.h"

@interface AuthService : AFOAuth2Manager

+ (instancetype)shareAuthService;

- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
                  success:(void (^)(AFOAuthCredential *credential))success
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
                   params:(NSDictionary *)params
                  success:(void (^)(AFOAuthCredential *credential))success
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)refreshTokenWithSuccess:(void (^)(AFOAuthCredential *newCredential))success
                        failure:(void (^)(NSError *error))failure;

- (void)signOut;

- (bool)isSignIn;

- (AFOAuthCredential *)retrieveCredential;

@end
