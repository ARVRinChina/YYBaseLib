//
//  UsersModel.h
//  xlzx
//
//  Created by tony on 16/1/12.
//  Copyright © 2016年 tony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EnumModel.h"

@interface UsersModel : NSObject

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *portraitUri;

/**
 *  真实姓名
 */
@property (nonatomic, copy) NSString *trueName;
/**
 *  用户名
 */
@property (nonatomic, copy) NSString *userName;
/**
 *  密码
 */
@property (nonatomic, copy) NSString *password;
/**
 *  性别 = ['保密', '男', '女']
 */
@property (nonatomic, assign) Sex sex;
/**
 *  邮箱
 */
@property (nonatomic, copy) NSString *email;
/**
 *  电话
 */
@property (nonatomic, copy) NSString *phone;
/**
 *  出生日期
 */
@property (nonatomic, strong) NSDate *birthdate;
/**
 *  年龄
 */
@property (nonatomic, assign) uint age;
/**
 *  城市Id
 */
@property (nonatomic, assign) NSInteger cityid;
/**
 *  城市名
 */
@property (nonatomic, copy) NSString *cityName;

/**
 *  婚姻情况 = ['保密', '已婚', '未婚', '离异', '单身', '恋爱中']
 */
@property (nonatomic, assign) Marriage marriage;
/**
 *  简介
 */
@property (nonatomic, copy) NSString *summary;
/**
 *  余额
 */
@property (nonatomic, assign) float account;
/**
 *  积分
 */
@property (nonatomic, assign) uint point;
/**
 *  经验
 */
@property (nonatomic, assign) uint experience;
/**
 *  等级Id
 */
@property (nonatomic, assign) NSInteger grade;
/**
 *  等级名称
 */
@property (nonatomic, copy) NSString *gradeName;
/**
 *  微信
 */
@property (nonatomic, copy) NSString *weixinId;
/**
 *  QQ
 */
@property (nonatomic, copy) NSString *qqId;
/**
 *  新浪
 */
@property (nonatomic, copy) NSString *sinaId;
/**
 *  极光标识
 */
@property (nonatomic, copy) NSString *registrationId;
/**
 *  用户类型 = ['普通用户', '咨询师用户', '机构管理员']
 */
@property (nonatomic, assign) UserType userType;
/**
 *  是否专家
 */
@property (nonatomic, assign) BOOL isExpert;
/**
 *  企业Id(EAP)
 */
@property (nonatomic, assign) NSInteger companyId;
/**
 *  工号
 */
@property (nonatomic, copy) NSString *jobNumber;
/**
 *  是否启用
 */
@property (nonatomic, assign) BOOL activity;
/**
 *  是否完善信息
 */
@property (nonatomic, assign) BOOL isComplete;
/**
 *  星座 = ['白羊座', '金牛座', '双子座', '巨蟹座', '狮子座', '处女座', '天平座', '天蝎座', '射手座', '摩羯座', '水瓶座', '双鱼座']
 */
@property (nonatomic, assign) Constellation constellation;
/**
 *  血型 = ['A型', 'B型', 'O型', 'AB型']
 */
@property (nonatomic, assign) BloodType blood;
/**
 *  学历 = ['初中及以下', '高中', '中技', '中专', '大专', '本科', '硕士', 'MBA', '博士']
 */
@property (nonatomic, assign) Education education;
/**
 *  职业 = ['计算机', '销售', '会计', '生产', '生物', '广告', '建筑', '人事', '咨询', '服务业', '公务员']
 */
@property (nonatomic, assign) Profession profession;
/**
 *  年收入 = ['五万以下', '五至八万', '八至十二万', '十二万至十五万', '十五万以上']
 */
@property (nonatomic, assign) AnnualIncome annualIncome;
/**
 *  个性签名
 */
@property (nonatomic, copy) NSString *signature;
/**
 *  关注数
 */
@property (nonatomic, assign) uint attentionNumber;
/**
 *   粉丝数
 */
@property (nonatomic, assign) uint fansNumber;
/**
 *   轨迹数
 */
@property (nonatomic, assign) uint userTraceNumber;
/**
 *  用户状态
 */
@property (nonatomic, assign) UserStatus status;
/**
 *  咨询师图文价格
 */
@property (nonatomic, assign) double graphicPrice;
/**
 *  咨询师电话价格
 */
@property (nonatomic, assign) double phonePrice;
/**
 *  咨询师线下价格
 */
@property (nonatomic, assign) double linePrice;
/**
 *  是否免费
 */
@property (nonatomic, assign) BOOL isFree;
/**
 *  标签
 */
@property (nonatomic, copy) NSString *tag;


- (void)save;
+ (instancetype)currentUser;
@end
