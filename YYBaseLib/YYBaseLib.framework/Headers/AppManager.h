//
//  AppManager.h
//  Common
//
//  Created by 银羽网络 on 16/7/15.
//  Copyright © 2016年 银羽网络. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UsersModel;

#define APPMENAGER [AppManager shareManager]

@interface AppManager : NSObject

@property (nonatomic, strong) UsersModel *userInfo;

@property (nonatomic, copy ,readonly) NSString *userId;

@property (nonatomic, strong) NSMutableArray         *cityList;                 //城市列表
@property (nonatomic, strong) NSMutableArray         *categoryList;             //技能列表
@property (nonatomic, strong) NSMutableArray         *consultGradeList;         //咨询师等级列表


+ (instancetype)shareManager;

/**
 *  保存用户信息
 *
 *  @return 是否保存成功
 */
- (BOOL)saveUserInfo;

/**
 *  用户退出登录
 */
- (void)userLogout;

/**
 *  用户是否登录
 *
 *  @return 结果
 */
- (BOOL)isUserLogin;

@end
