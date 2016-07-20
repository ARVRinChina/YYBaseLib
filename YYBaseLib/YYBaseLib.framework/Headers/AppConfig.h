//
//  AppConfig.h
//  xlzx
//
//  Created by tony on 15/7/27.
//  Copyright (c) 2015年 tony. All rights reserved.
//

#ifndef heyyou_AppConfig_h
#define heyyou_AppConfig_h

#define PageSize 20

#define kScreenBounds [UIScreen mainScreen].bounds //屏幕尺寸
#define kScreenWidth   [UIScreen mainScreen].bounds.size.width//屏幕宽度
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height//屏幕高度

#define iPhone6                                                                \
([UIScreen instancesRespondToSelector:@selector(currentMode)]                \
? CGSizeEqualToSize(CGSizeMake(750, 1334),                              \
[[UIScreen mainScreen] currentMode].size)           \
: NO)
#define iPhone6Plus                                                            \
([UIScreen instancesRespondToSelector:@selector(currentMode)]                \
? CGSizeEqualToSize(CGSizeMake(1242, 2208),                             \
[[UIScreen mainScreen] currentMode].size)           \
: NO)

#pragma mark -- 颜色相关

#define KTabbarBgColor [UIColor colorWithHexString:@"#FFFFFF"] //Tabbar背景白色
#define KbgBlueColor [UIColor colorWithHexString:@"#00AFF8"] //背景浅蓝色
#define KbgColor0  [UIColor colorWithHexString:@"#E3E7EA"] //背景深首页
#define KbgColor1  [UIColor colorWithHexString:@"#F4F4F4"] //背景浅灰
#define KbgColor2  [UIColor color:227 green:231 blue:234 alpha:1.0f]//背景深灰
#define KbgColor3  [UIColor color:238 green:239 blue:241 alpha:1.0f]//背景浅灰
#define KbgOrageColor [UIColor colorWithHexString:@"#FF6737"] // 背景橙色

#define KFontBlackColor1 [UIColor colorWithHexString:@"#313131"] // 黑色
#define KFontBlackColor2  [UIColor colorWithHexString:@"#6F6F6F"]//字体浅黑

#define KFontGrayColor1  [UIColor colorWithHexString:@"#C9C9C9"]//字体浅灰
#define KFontGrayColor2  [UIColor colorWithHexString:@"#DDDDDD"]//字体浅灰还要比KFontGrayColor1浅

#define KFontOrangeColor [UIColor colorWithHexString:@"#FF6737"]//字体橙色
#define kFontGreenColor1 [UIColor color:96 green:160 blue:84 alpha:1.0f]//绿色字体

#define KInputBorderColor [UIColor color:198 green:198 blue:198 alpha:1.0f]//输入框边框颜色

#define KbgDisableColor  [UIColor color:160 green:160 blue:160 alpha:1.0f]//禁用色

#define KLineBgColor [UIColor colorWithHexString:@"#DDDDDD"] // 分割线颜色

#pragma mark - 未加载时显示图片
// 头像
#define kNormalFaceName @"icon_normal"
#define kNormalImageName @"icon_normal_Photo"

#pragma mark -- 接口地址相关
//开发地址
#define AFAppDotNetAPIBaseURLString @"http://139.196.104.99:8060/api/"
#define ImageBaseUrl    @"http://139.196.104.99:8020/"

//#define AFAppDotNetAPIBaseURLString @"http://api.heyyou.com.cn/api/"
//#define ImageBaseUrl    @"http://api.heyyou.com.cn"
#define KShareUrl    @"http://139.196.104.99:8060/share.html?id=%@&type=%@"

#pragma mark -- 用户数据存放地址
//#define golfMembersFilePath  [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/golfMembers.db"]

//支付宝配置
#define KAliPartner @"2088021911063148"
#define KAliSeller  @"anytimetech@163.com"
#define KAliPrivateKey  @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMfPCXIXinK114ODBcscftHlwGMSJFUKSCQVqQIZshwUHb/GGYHatIv6UmpqTWQ/H8hinUK7SEWErywbyXBifd/IoJwnZ7tCN5naewhndqNvDPGx5gczznAsxeZSyFMTsugMoO/1O8JiLa3wd9RZv9oNf6IUy9CBaCIuh64mJoI9AgMBAAECgYBdl4MLKC+3r6m1dmf+TeixlPba8SKHmvtTu7mgvDyLnniY3cgQ5Urwzl5Qbl61+EOA74BOQ7+EoLQU6yceN2RR24u/s5AbRVahbfHbuyuc8t+ZeEs3Q+66rFiBobsf3V0P47PhFSC/jsq36byaUbMZgbYBPqWG1B06+pxsuGfMAQJBAPoL1wzdbg0Pi0hcHIyF/uy3x+rvjcb4ZsFDdOfZV+ZvlgP/JDFPG5bFbvqJSOxJExG35B5xoBrjvobkThIydIECQQDMkPk2oO1xlXqX5cQzm+XI/tCuUqCX945F1uMUmUXtIEBl5pazx+tlw/Srm40o3qRAe8eY3LynZX3Kooe/2v+9AkEA63m2/eCRwS8ARhaotBWEazzvwmnypIxNiHeUYrslslcneYAPf3g2TRiFWN9sk0iF8suwwpLS6j/Lr5DVjQGDAQJAa/WawHzfsxEbWOzWxhHhjFkGkulifbEVccA9qZJWeBWMRvsRz6GTlup6xtJaBhayAqIQrZjZK1MBtx5dnCAc1QJBAKBsdyq7IbldRByJS58grGbTeRxwS2yq07oWNu30h0F8SUNKNFVTR44z0yDIp6eeJ05cCoWYO/hVkjPV42l/arQ="
#define KAliNotifyURL @"http://139.196.104.99:8060/Pay/AliPayNotify.aspx"
#define kNotificationRechargeSuccess @"kNotificationRechargeSuccess"

#pragma mark -- 关键字Key
//用户信息
#define KUserInfo @"KUserInfo"
// 缓存用户名
#define KCacheUserName @"KCacheUserName"
// 缓存用户密码
#define KCacheUserPassword @"KCacheUserPassword"
//登录成功通知
#define KNotificationUserLoginName  @"KNotificationUserLoginName"
//用户定位信息
#define KUserLocation @"KUserLocation"
//定位成功通知
#define KNotificationUserLocationName   @"KNotificationUserLocationName"
//音效开关设置
#define KSoundSetting @"KSoundSetting"
//是否首次打开
#define KIsFirst @"KIsFirst"
//是否显示测试
#define KIsShowTest @"KIsShowTest"
//系统消息的通知
#define KSystemMessageNotification @"KSystemMessageNotification"
//第三方登录账号
#define KOtherLoginName @"KOtherLoginName"
//新的朋友消息数组
#define KNewFriendsMessage @"KNewFriendsMessage"
//未读的新的好友消息数
#define KNewFriendsUnreadCount @"KNewFriendsUnreadCount"
// 新的好友请求的通知
#define KNewFriendMessageNotification @"KNewFriendMessageNotification"
//保存融云Token的key值
#define KRCToken @"KRCToken"
//融云Appkey
#define RONGCLOUD_IM_APPKEY @"e0x9wycfxlguq"
//友盟Appkey
#define UMENG_APPKEY @"56f4de54e0f55a52580011a5"
//微信AppID
#define WEIXIN_APPID @"wx1d7d51a88087dab1"
//微信AppKey
#define WEIXIN_APPKEY @"eb80b5a623b341adf835f025fa2bd843"
//QQ AppID
#define QQ_APPID @"1105274378"
//QQ AppKey
#define QQ_APPKEY @"ACrxenRXkpX8yMIo"
//新浪AppKEY
#define SINA_APPKEY @"1562501829"
//新浪AppSecret
#define SINA_APPSECRET @"496d5f41d84b4d19b7084e59537e22fc"
//百度地图AppKey
#define BAIDUMAP_APPKEY @"k8zOVg81bCHCxvCTdBwOu2QZmlS6XF19"
//极光推送AppKey
#define JPUSH_APPKEY @"c0eb21173c7ed010b78372bb"
//极光推送,是否生产环境,发布时修改为YES
#define JPUSH_IsProduction YES

#pragma mark - 常用提示信息
// 网络错误提醒
#define kNetworkErrorPrompt [MBProgressHUD autoShowAndHideWithMessage:@"网络错误,请稍后再试..."]
// 接口返回数据错误提示
#define kInterfaceErrorMsg [MBProgressHUD autoShowAndHideWithMessage:responseObject[@"msg"]]

#pragma mark - 常用的方法
// 图片
#define kImageNamed(name) [UIImage imageNamed:(name)]
// 字体
#define kFont(size) [UIFont systemFontOfSize:(size)];
// 颜色
#define kColor(color) [UIColor (color)]

#endif
