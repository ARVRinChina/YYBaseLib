//
//  DataVerify.h
//  HappyRadio
//
//  Created by terry.tang on 14/12/27.
//  Copyright (c) 2014年 niklas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataVerify : NSObject

//昵称
+ (BOOL) validateNickname:(NSString *)nickname;
//姓名一般只允许包含中文或英文字母
+ (BOOL)isValidateName:(NSString *)name;
//用户名
+ (BOOL) validateUserName:(NSString *)name;
//密码
+ (BOOL) validatePassword:(NSString *)passWord;
//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;
//邮箱
+ (BOOL) validateEmail:(NSString *)email;
//电话验证
+ (BOOL) validateTel:(NSString *)tel;
//数字
+ (BOOL) validateNumber:(NSString *)number;
// 身份证验证
+ (BOOL)validateIDCardNumber:(NSString *)value;
@end
