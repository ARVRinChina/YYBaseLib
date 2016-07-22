//
//  AppManager.m
//  Common
//
//  Created by 银羽网络 on 16/7/15.
//  Copyright © 2016年 银羽网络. All rights reserved.
//

#import "AppManager.h"
#import "AppConfig.h"
#import "YYModel.h"
#import "ApiService.h"
#import "CommonTool.h"
#import "BaseViewController.h"
#import "UsersModel.h"
#import "CityModel.h"
#import "CategoryModel.h"
#import "ConsultGradeModel.h"

@implementation AppManager

static AppManager *_manager = nil;

+ (id)allocWithZone:(struct _NSZone *)zone {
    if (_manager == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _manager = [super allocWithZone:zone];
        });
    }
    return _manager;
}

- (id)init
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super init];
        [_manager getCityList];
        [_manager getCategoryList];
        [_manager getConsultGradeList];
    });
    return _manager;
}

+ (instancetype)shareManager
{
    return [[self alloc] init];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return _manager;
}
+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return _manager;
}

/**
 *  保存用户信息
 *
 *  @return 是否保存成功
 */
- (BOOL)saveUserInfo{
    if(self.userInfo.password && self.userInfo.password.length > 0){
        [[NSUserDefaults standardUserDefaults] setObject:self.userInfo.userName forKey:KCacheUserName];
        [[NSUserDefaults standardUserDefaults] setObject:self.userInfo.password forKey:KCacheUserPassword];
    }
    
    NSDictionary *dict = [self.userInfo yy_modelToJSONObject];
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:KUserInfo];
    BOOL ret = [[NSUserDefaults standardUserDefaults] synchronize];
    if (ret) {
        NSLog(@"保存用户信息成功");
    }else
    {
        NSLog(@"保存用户信息失败");
    }
    return ret;
}

#pragma mark - 点击退出登录
- (void)userLogout{
    // 清空用户信息
    self.userInfo = nil;
    [self saveUserInfo];
    
    //接口退出
    [[ApiService shareAPIService] logOut];
    
        UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber = 0;
}

/**
 *  用户是否登录
 *
 *  @return 结果
 */
- (BOOL)isUserLogin{
    if (self.userInfo) {
        return YES;
    }
    
    UINavigationController *loginNav = (UINavigationController *)[BaseViewController getViewControllerWithName:@"UserLoginNavigationController" forStoryboard:@"Common"];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window.rootViewController presentViewController:loginNav animated:YES completion:nil];
    return NO;
}

/**
 *  获取城市列表
 */
- (void)getCityList
{
    self.cityList = [[NSMutableArray alloc] init];
    [APISERVICE GetData:@"System/GetCityList" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         if(![responseObject[@"success"] boolValue])
         {
             return;
         }
         self.cityList = [[NSArray yy_modelArrayWithClass:[CityModel class] json:responseObject[@"result"]] mutableCopy];
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"获取城市列表错误");
     }];
}

/**
 *  获取技能列表
 */
- (void)getCategoryList
{
    self.categoryList = [[NSMutableArray alloc] init];
    [APISERVICE GetData:@"Advisory/GetCategoryList" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         if(![responseObject[@"success"] boolValue])
         {
             return;
         }
         self.categoryList = [[NSArray yy_modelArrayWithClass:[CategoryModel class] json:responseObject[@"result"]] mutableCopy];
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"获取技能列表错误");
     }];
}

/**
 *  获取咨询师等级列表
 */
- (void)getConsultGradeList
{
    self.consultGradeList = [[NSMutableArray alloc] init];
    [APISERVICE GetData:@"System/GetConsultGradeList" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         if(![responseObject[@"success"] boolValue])
         {
             return;
         }
         self.consultGradeList = [[NSArray yy_modelArrayWithClass:[ConsultGradeModel class] json:responseObject[@"result"]] mutableCopy];
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"获取咨询师等级列表错误");
     }];
}

@end
