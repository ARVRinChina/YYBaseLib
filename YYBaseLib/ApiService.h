//
//  ApiService.h
//  Sconit
//
//  Created by tony on 15/12/2.
//  Copyright © 2015年 tony. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "MBProgressHUD.h"
#import "MBProgressHUD+MBProgressHUD_Category.h"
#define APISERVICE [ApiService shareAPIService]


@interface ApiService : AFHTTPSessionManager

+ (instancetype)shareAPIService;
@property (strong, nonatomic) NSMutableDictionary   *userToken;


- (id)initWithBaseURL:(NSURL *)url;

- (void)logOut;

- (void)GetDataLoading:(NSString *)URLString
            parameters:(id)parameters
               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)GetData:(NSString *)URLString
     parameters:(id)parameters
        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)PostDataLoading:(NSString *)URLString
      parameters:(id)parameters
         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)PostData:(NSString *)URLString
      parameters:(id)parameters
         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)DeleteData:(NSString *)URLString
        parameters:(id)parameters
           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  上传图片
 *
 *  @param image   图片
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
- (void)uploadImage:(UIImage *)image success:(void(^)(NSString *imageUrlStr))success failure:(void (^)(NSError *error))failure;

/**
 *  获取验证码
 */
- (void)getCodeWithMobile:(NSString *)mobile;


/**
 *  根据用户Id获取用户信息
 *
 *  @param userId  用户ID
 */
- (void)getUserInfoWithUserId:(NSString *)userId success:(void(^)(id response))success failure:(void (^)(NSError *error))failure;

@end
