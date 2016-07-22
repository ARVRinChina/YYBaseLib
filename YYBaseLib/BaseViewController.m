//
//  BaseViewController.m
//  xlzx
//
//  Created by tony on 15/7/27.
//  Copyright (c) 2015年 tony. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (strong, nonatomic) UIView *indicateV;//第一次显示的指示view
@property (strong, nonatomic) NSMutableArray *indicateImageA;
@end

@implementation BaseViewController

//获取ViewController 实例
+ (instancetype)getViewControllerClass:(Class)classObject forStoryboard:(NSString *)storyboard
{
    NSString *classNmae = NSStringFromClass(classObject);
    return [BaseViewController getViewControllerWithName:classNmae forStoryboard:storyboard];
}

//获取ViewController 实例
+ (instancetype)getViewControllerWithName:(NSString *)className forStoryboard:(NSString *)storyboard
{
    return [[UIStoryboard storyboardWithName:storyboard bundle:nil] instantiateViewControllerWithIdentifier:className];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.navigationController.viewControllers.count > 1) {
        self.tabBarHidden = YES;
    }else
    {
        self.tabBarHidden = NO;
    }
    
//    NSLog(@"navigationController -- %@",self.navigationController.viewControllers);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initToUI];
    [self initToData];
    
    if([self isPayPage])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(knotificationRechargeSuccess:) name:kNotificationRechargeSuccess object:nil];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
//    self.appManager = nil;
    if([self isPayPage])
        [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationRechargeSuccess object:nil];
}

#pragma mark - UI
//初始化UI
- (void)initToUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = KbgColor1;
    self.tableView.backgroundColor = KbgColor1;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.appManager = [AppManager shareManager];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_arrow_left"] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnSelected:)];
    
    if([self isRefreshTableView]){
        [self setupRefresh];
    }
}


- (void)initToData
{
    if(self.dataSources == nil)
        self.dataSources = [[NSMutableArray alloc] init];
}

- (void)setTabBarHidden:(BOOL)tabBarHidden
{
    _tabBarHidden = tabBarHidden;
}

//自定义返回按钮
- (void)setCustormBackButton:(NSString *)titleBtn
{
    titleBtn = [titleBtn isEqualToString:@""]? @"                ":titleBtn;
    [self setCustormBackButton:titleBtn image:[UIImage imageNamed:@"back"]];
}

//自定义返回按钮
- (void)setCustormBackButton:(NSString *)titleBtn image:(UIImage *)img
{
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtn setImage:img forState:UIControlStateNormal];
    [self.backBtn setTitle:[NSString stringWithFormat:@" %@",titleBtn] forState:UIControlStateNormal];
    [self.backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.backBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    self.backBtn.frame = CGRectMake(0, 0, 80, 46);
    [self.backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
    [self.backBtn addTarget:self action:@selector(backBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.hidesBackButton = YES ;
}

//自定义右边按钮
- (void)setCustormRightButton:(NSString *)titleBtn
{
    [self setCustormRightButton:titleBtn image:nil];
}

- (void)setCustormRightButton:(NSString *)titleBtn image:(UIImage *)img
{
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBtn setImage:img forState:UIControlStateNormal];
    [self.rightBtn setTitle:[NSString stringWithFormat:@"%@",titleBtn] forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor colorWithHexString:@"#6F6F6F"] forState:UIControlStateNormal];
    [self.rightBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
    self.rightBtn.frame = CGRectMake(0, 0, 100, 42);
    [self.rightBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    [self.rightBtn addTarget:self action:@selector(rightBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
}

//自定义左边按钮返回回调
- (void)backBtnSelected:(UIButton *)button
{
    [MBProgressHUD hideMessage];
    if(self.callback)
        self.callback(self);
    [self.navigationController popViewControllerAnimated:YES];
}

//自定义右边回调
- (void)rightBtnSelected:(UIButton *)button
{
    NSLog(@"rightBtnSelected");
}

#pragma mark - MJRefresh
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(tableViewHeaderRereshing)];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(tableViewFooterRereshing)];
    
}

//下拉更多
- (void)tableViewHeaderRereshing
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
}
//上拉更多
- (void)tableViewFooterRereshing
{
    [self.tableView reloadData];
    [self.tableView.mj_footer endRefreshing];
}
//是否增加刷新功能
- (BOOL)isRefreshTableView
{
    return NO;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    [self toViewController:segue.destinationViewController sender:sender];
}

- (void)toViewController:(BaseViewController *)viewController sender:(id)sender
{
    
}

//#pragma mark - TableView
//-(void)setExtraCellLineHidden: (UITableView *)tableView
//{
//    UIView *view = [UIView new];
//    view.backgroundColor = [UIColor clearColor];
//    [tableView setTableFooterView:view];
//}

/**
 *  cell将要出现时，初始化分割线的位置顶格（大多ViewController不需要）
 */
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Remove seperator inset
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//    
//    // Prevent the cell from inheriting the Table View's margin settings
//    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
//        [cell setPreservesSuperviewLayoutMargins:NO];
//    }
//    
//    // Explictly set your cell's layout margins
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
//}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSources count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/**
 *  每组的头部视图
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
/**
 *  每组的尾部视图
 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView rowHeight];
}

#pragma mark - Pay
/*
 resultStatus =
 9000 订单支付成功
 8000 正在处理中
 4000 订单支付失败
 6001 用户中途取消
 6002 网络连接出错
 */
- (void)knotificationRechargeSuccess:(NSNotification *)notification
{
    [self paySuccess:notification.userInfo];
}
//是否是支付页面
- (BOOL)isPayPage{
    return NO;
}
//支付成功后回调
- (void)paySuccess:(NSDictionary *)payinfo{
}

//获取图片地址
- (NSURL*)getImageUrl:(NSString *)imageUrl substringFromIndex:(NSInteger)index
{
    if (imageUrl == nil || imageUrl.length <= 0) {
        return nil;
    }
    
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", ImageBaseUrl, [imageUrl substringFromIndex:index]]];
}
- (NSURL*)getImageUrl:(NSString *)imageUrl
{
    return [self getImageUrl:imageUrl substringFromIndex:3];
}


-(void)isFirstShowithImageArray:(NSArray *)imageArray WithTitle:(NSString *)key {
    NSString *str  = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (!str ) {   //如果没有数据
        [self creatIndicateV:imageArray];
        [[NSUserDefaults standardUserDefaults] setObject:@"false" forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

-(void)creatIndicateV:(NSArray *)imageArray{
    if (self.indicateV) {
        [self.indicateV removeFromSuperview];
    }
    if (imageArray.count <1) {
        return;
    }
    UIView *view = [[UIView alloc] initWithFrame:kScreenBounds];
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[imageArray firstObject]]];
    imageV.frame = view.frame;
    imageV.userInteractionEnabled = YES;
    [view addSubview:imageV];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRemove)];
    [imageV addGestureRecognizer:tap];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    self.indicateV = view;
}
-(void)tapRemove{
    [self.indicateImageA removeObjectAtIndex:0];
    [self creatIndicateV:self.indicateImageA];
   
}
-(void)into{
    NSLog(@"into");
    [self.indicateV removeFromSuperview];
      self.tabBarHidden  = YES;
}

@end


@implementation UIImageView (BaseController)
- (void)setUrlByName:(NSString *)url
{
    self.image = nil;
    if( url==nil || url.length <= 0)
        return;
    NSString *urlStr = [url substringFromIndex:3];
    urlStr = [NSString stringWithFormat:@"%@%@",ImageBaseUrl,urlStr];
//    [self setUrl:urlStr];
}




@end