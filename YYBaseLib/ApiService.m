//
//  ApiService.m
//  Sconit
//
//  Created by tony on 15/12/2.
//  Copyright © 2015年 tony. All rights reserved.
//

#import "ApiService.h"
#import "AppConfig.h"
#import "AuthService.h"
#import "AFOAuth2RequestSerializer.h"
#import "AppManager.h"
#import "CommonTool.h"
#import "UsersModel.h"

typedef void (^ApiRetryBlock)(NSURLSessionDataTask *task, NSError *error);
typedef NSURLSessionDataTask *(^ApiCreateTask)(ApiRetryBlock retryBlock);
static const int kRetryCount = 3;

@implementation ApiService

+ (instancetype)shareAPIService
{
    static ApiService *_shareAPIService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareAPIService = [[ApiService alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
    });
    
    return _shareAPIService;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    AFOAuthCredential *credential = [[AuthService shareAuthService] retrieveCredential];
    if (credential != nil) {
        self.requestSerializer = [AFOAuth2RequestSerializer serializerWithCredential:credential];
    }
    
    return self;
}

-(void)logOut {
    [[AuthService shareAuthService] signOut];
    [[ApiService shareAPIService] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
}

- (void)refreshAccessToken:(ApiCreateTask)createTaskBlock
                   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
                retryCount:(int)retryCount
{
    [[AuthService shareAuthService] refreshTokenWithSuccess:^(AFOAuthCredential *newCredential) {
        self.requestSerializer = [AFOAuth2RequestSerializer serializerWithCredential:newCredential];
        [self taskWithRetry:createTaskBlock failure:failure retryCount:retryCount];
    } failure:^(NSError *error) {
        AppManager *appManager = APPMENAGER;
        if (appManager.userInfo) {
            [[AuthService shareAuthService] loginWithUsername:appManager.userInfo.userName password:appManager.userInfo.password success:^(AFOAuthCredential *credential) {
                self.requestSerializer = [AFOAuth2RequestSerializer serializerWithCredential:credential];
                [self taskWithRetry:createTaskBlock failure:failure retryCount:retryCount];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                appManager.userInfo = nil;
                [appManager saveUserInfo];
                if (failure != nil) {
                    failure(nil, error);
                }
            }];
        }
        else {
            if (failure != nil) {
                failure(nil, error);
            }
        }
    }];
}

- (void)taskWithRetry:(ApiCreateTask)createTaskBlock
              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
           retryCount:(int)retryCount
{
    ApiRetryBlock retryBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        
        if (retryCount > 0) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
            if (httpResponse.statusCode == 401) {
                [self refreshAccessToken:createTaskBlock failure:failure retryCount:retryCount - 1];
            }
            else {
                [self taskWithRetry:createTaskBlock failure:failure retryCount:retryCount - 1];
            }
        }
        else {
            if (failure != nil) {
                failure(task, error);
            }
        }
    };

    if (retryCount != kRetryCount && [self.requestSerializer isKindOfClass:[AFOAuth2RequestSerializer class]]) {
        AFOAuth2RequestSerializer *serializer = (AFOAuth2RequestSerializer *)self.requestSerializer;
        if (serializer.credential.isExpired) {
            [self refreshAccessToken:createTaskBlock failure:failure retryCount:retryCount];
        }
        else
        {
            createTaskBlock(retryBlock);
        }
    }
    else {
        createTaskBlock(retryBlock);
    }
}

- (void)GetDataLoading:(NSString *)URLString
            parameters:(id)parameters
               success:(void (^)(NSURLSessionDataTask *, id))success
               failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    [MBProgressHUD showMessage:@"正在加载中"];
    
    ApiCreateTask createTaskBlock = ^NSURLSessionDataTask *(void (^retryBlock)(NSURLSessionDataTask *task, NSError *error)) {
        NSURLSessionDataTask *createdTask = [self GET:URLString
                                           parameters:parameters
                                              success:^(NSURLSessionDataTask *task, id responseObject) {
                                                  [MBProgressHUD hideMessage];
                                                  if (success) {
                                                      success(task, responseObject);
                                                  }
                                              }
                                              failure:retryBlock];
        return createdTask;
    };
    
    ApiRetryBlock failureBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideMessage];
        if (failure) {
            failure(task, error);
            return;
        }
        [MBProgressHUD autoShowAndHideWithMessage:@"网络错误,请稍后再试..."];
    };
    
    [self taskWithRetry:createTaskBlock failure:failureBlock retryCount:kRetryCount];
}

- (void)GetData:(NSString *)URLString
     parameters:(id)parameters
        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    ApiCreateTask createTaskBlock = ^NSURLSessionDataTask *(void (^retryBlock)(NSURLSessionDataTask *task, NSError *error)) {
        NSURLSessionDataTask *createdTask = [self GET:URLString
                                           parameters:parameters
                                              success:^(NSURLSessionDataTask *task, id responseObject) {
                                                  if (success) {
                                                      success(task, responseObject);
                                                  }
                                              }
                                              failure:retryBlock];
        return createdTask;
    };
    
    ApiRetryBlock failureBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    };
    
    [self taskWithRetry:createTaskBlock failure:failureBlock retryCount:kRetryCount];
}

- (void)PostData:(NSString *)URLString
             parameters:(id)parameters
                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    ApiCreateTask createTaskBlock = ^NSURLSessionDataTask *(void (^retryBlock)(NSURLSessionDataTask *task, NSError *error)) {
        NSURLSessionDataTask *createdTask = [self POST:URLString
                                            parameters:parameters
                                               success:^(NSURLSessionDataTask *task, id responseObject) {
                                                   if (success) {
                                                       success(task, responseObject);
                                                   }
                                               }
                                               failure:retryBlock];
        return createdTask;
    };
    
    ApiRetryBlock failureBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
            return ;
        }
    };
    
    [self taskWithRetry:createTaskBlock failure:failureBlock retryCount:kRetryCount];
}


- (void)PostDataLoading:(NSString *)URLString
      parameters:(id)parameters
         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [MBProgressHUD showMessage:@"正在加载..."];
    ApiCreateTask createTaskBlock = ^NSURLSessionDataTask *(void (^retryBlock)(NSURLSessionDataTask *task, NSError *error)) {
        NSURLSessionDataTask *createdTask = [self POST:URLString
                                            parameters:parameters
                                               success:^(NSURLSessionDataTask *task, id responseObject) {
                                                   [MBProgressHUD hideMessage];
                                                   if (success) {
                                                       success(task, responseObject);
                                                   }
                                               }
                                               failure:retryBlock];
        return createdTask;
    };
    
    ApiRetryBlock failureBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideMessage];
        if (failure) {
            failure(task, error);
            return ;
        }
        [MBProgressHUD autoShowAndHideWithMessage:@"网络错误,请稍后再试..."];
    };
    
    [self taskWithRetry:createTaskBlock failure:failureBlock retryCount:kRetryCount];
}

- (void)DeleteData:(NSString *)URLString
      parameters:(id)parameters
         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    ApiCreateTask createTaskBlock = ^NSURLSessionDataTask *(void (^retryBlock)(NSURLSessionDataTask *task, NSError *error)) {
        NSURLSessionDataTask *createdTask = [self DELETE:URLString
                                            parameters:parameters
                                               success:^(NSURLSessionDataTask *task, id responseObject) {
                                                   if (success) {
                                                       success(task, responseObject);
                                                   }
                                               }
                                               failure:retryBlock];
        return createdTask;
    };
    
    ApiRetryBlock failureBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
            return ;
        }
    };
    
    [self taskWithRetry:createTaskBlock failure:failureBlock retryCount:kRetryCount];
}


#pragma mark - 接口

/**
 *  上传图片
 *
 *  @param image   图片
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
- (void)uploadImage:(UIImage *)image success:(void(^)(NSString *imageUrlStr))success failure:(void (^)(NSError *error))failure{
    image = [CommonTool imageWithImage:image scaledToFileSize:500*1024];
    [MBProgressHUD showMessage:@"上传中"];
    APISERVICE.responseSerializer.acceptableContentTypes = [APISERVICE.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [APISERVICE POST:[NSString stringWithFormat:@"%@api/UploadPhoto.aspx", ImageBaseUrl] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        
        //生成文件名
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", [formatter stringFromDate:[NSDate date]]];
        
        //上传图片
        [formData appendPartWithFileData:imageData name:@"fileAddPic" fileName:fileName mimeType:@"image/jpeg"];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [MBProgressHUD hideMessage];
        if (success) {
            if (![responseObject[@"success"] boolValue]) {
                
                [MBProgressHUD autoShowAndHideWithMessage:responseObject[@"msg"]];
                return ;
            }
            success(responseObject[@"msg"]);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideMessage];
        if (failure) {
            failure(error);
        }
        kNetworkErrorPrompt;
    }];
}

/**
 *  根据用户Id获取用户信息
 *
 *  @param userId  用户ID
 */
- (void)getUserInfoWithUserId:(NSString *)userId success:(void(^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *urlString = [NSString stringWithFormat:@"Users/GetUserInfo/%@",userId];
    [APISERVICE GetData:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (![responseObject[@"success"] boolValue]) {
            [MBProgressHUD autoShowAndHideWithMessage:responseObject[@"msg"]];
            if (success) {
                success(nil);
            }
            return ;
        }
        
        if (success) {
            success(responseObject[@"result"]);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }else{
            kNetworkErrorPrompt;
        }
    }];
}

/**
 *  获取验证码
 */
- (void)getCodeWithMobile:(NSString *)mobile{
    [APISERVICE GetData:@"Users/GetCode" parameters:@{@"mobile":mobile} success:^(NSURLSessionDataTask *task, id responseObject) {
        if (![responseObject[@"success"] boolValue]) {
            [MBProgressHUD autoShowAndHideWithMessage:responseObject[@"msg"]];
            return ;
        }
        [MBProgressHUD autoShowAndHideWithMessage:@"验证码已经发送，请注意查收"];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        kNetworkErrorPrompt;
    }];
}

@end
