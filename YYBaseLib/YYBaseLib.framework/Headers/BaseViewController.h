//
//  BaseViewController.h
//  xlzx
//
//  Created by tony on 15/7/27.
//  Copyright (c) 2015年 tony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UsersModel.h"
#import "AppManager.h"
#import "AppConfig.h"
#import "UIColor_Extensions.h"
#import "UIImage+UIImage.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIButton+FillColor.h"
#import "UIView+extensions.h"
#import "MJRefresh.h"
#import <MapKit/MapKit.h>
#import "ApiService.h"
#import "NSString_Extensions.h"
#import "YYModel.h"

@class BaseViewController;
typedef void (^viewControllerCallback)(BaseViewController *viewController);

@interface BaseViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property(strong, nonatomic)IBOutlet UITableView *tableView;
@property(strong, nonatomic)UIButton *backBtn;
@property(strong, nonatomic)UIButton *rightBtn;
@property(strong, nonatomic)AppManager *appManager;
@property(strong, nonatomic)NSMutableArray *dataSources;
@property(strong, nonatomic)viewControllerCallback callback;
@property(assign, nonatomic)BOOL tabBarHidden;



//获取ViewController 实例
+ (instancetype)getViewControllerClass:(Class)classObject forStoryboard:(NSString *)storyboard;
//获取ViewController 实例
+ (instancetype)getViewControllerWithName:(NSString *)className forStoryboard:(NSString *)storyboard;

//初始化UI
- (void)initToUI;
//初始化UI
- (void)initToData;
//自定义返回按钮
- (void)setCustormBackButton:(NSString *)titleBtn;
//自定义返回按钮
- (void)setCustormBackButton:(NSString *)titleBtn image:(UIImage *)img;
//自定义右边按钮
- (void)setCustormRightButton:(NSString *)titleBtn;
//自定义右边按钮
- (void)setCustormRightButton:(NSString *)titleBtn image:(UIImage *)img;
//下拉更多
- (void)tableViewHeaderRereshing;
//上拉更多
- (void)tableViewFooterRereshing;
//是否增加刷新功能
- (BOOL)isRefreshTableView;
//跳转页面
- (void)toViewController:(BaseViewController *)viewController sender:(id)sender;
/**
 *  跳转到用户详情界面
 *
 *  @param userId 用户Id
 */
- (void)gotoUserInfoViewControllerWithUserId:(NSString *)userId;
//自定义左边按钮返回回调
- (void)backBtnSelected:(UIButton *)button;
//自定义右边回调
- (void)rightBtnSelected:(UIButton *)button;
//是否是支付页面
- (BOOL)isPayPage;
//支付成功后回调
- (void)paySuccess:(NSDictionary *)payinfo;
//获取图片地址
- (NSURL*)getImageUrl:(NSString *)imageUrl substringFromIndex:(NSInteger)index;
- (NSURL*)getImageUrl:(NSString *)imageUrl;
-(void)tapRemove;

/**
 *  显示 指引页
 *
 *  @param imageArray 图片名称数组
 *  @param Str        沙河保存的key 传英文
 */
-(void)isFirstShowithImageArray:(NSArray *)imageArray WithTitle:(NSString *)key;
@end


@interface UIImageView (BaseController)
- (void)setUrlByName:(NSString *)url;



@end;