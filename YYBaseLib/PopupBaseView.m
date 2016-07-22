//
//  PopupBaseView.m
//  xlzx
//
//  Created by 银羽网络 on 16/1/28.
//  Copyright © 2016年 tony. All rights reserved.
//

#import "PopupBaseView.h"
#import "UIColor_Extensions.h"
#import "UIView+extensions.h"
#import "AppConfig.h"

@interface PopupBaseView ()

/**
 *  遮盖的背景图
 */
@property (nonatomic, weak) UIImageView *coverView;

/**
 *  头部视图
 */
@property (nonatomic, weak) UIView *headerView;

/**
 *  标题
 */
@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIView *popupView;

@end

@implementation PopupBaseView

+ (instancetype)popupView{
    PopupBaseView *popupBaseView = [[PopupBaseView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    return popupBaseView;
}

- (instancetype)initWithDelegate:(id)delegate{
    PopupBaseView *popupView = [PopupBaseView popupView];
    popupView.delegate = delegate;
    return popupView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showCancelButton = YES;
        self.showConfirmButton = YES;
        self.showCoverView = YES;
        self.marginLength = 10;
        self.cancelButtonColor = [UIColor clearColor];
//        self.confirmButtonColor = KbgOrageColor;
    }
    return self;
}

/**
 *  显示弹出视图到父视图的window上，没有动画效果
 */
- (void)showPopupViewToView:(UIView *)superView{
    [self showPopupViewToView:superView animation:NO];
}

/**
 *  显示弹出视图到父视图的window上，有动画效果
 */
- (void)showPopupViewToView:(UIView *)superView animation:(BOOL)animation{
    [self.superview endEditing:YES];
    [self createCoverViewIsAnimation:animation completion:^{
        
        // 弹出视图
        UIView *popupView = [[UIView alloc] initWithFrame:CGRectMake(self.marginLength, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width - 2 * self.marginLength, 0)];
        popupView.backgroundColor = [UIColor clearColor];
        [self addSubview:popupView];
        self.popupView = popupView;
        
        // 头部视图
        [self createHeaderView];
        
        // 弹出视图的自定义视图
        UIView *popupCustomView = nil;
        if ([self.delegate respondsToSelector:@selector(popupViewToPopupBaseView:)]) {
            popupCustomView = [self.delegate popupViewToPopupBaseView:self];
        }else{
            popupCustomView = [[UIView alloc] init];
        }
        
        popupCustomView.frame  = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), self.popupView.frame.size.width, popupCustomView.frame.size.height);
        [self.popupView addSubview:popupCustomView];
        popupCustomView.backgroundColor = [UIColor whiteColor];
        
        CGFloat duration = 0;
        if (animation) {
            duration = 0.3;
        }
        [UIView animateWithDuration:duration animations:^{
            popupView.frame = CGRectMake(self.marginLength, self.frame.size.height - popupCustomView.frame.size.height - self.headerView.frame.size.height, popupView.frame.size.width, popupCustomView.frame.size.height + self.headerView.frame.size.height);
        } completion:nil];
        
    }];
    
    [superView addSubview:self];
}

/**
 *  从父视图的window上移除弹出视图，没有动画
 */
- (void)hidePopupViewToView:(UIView *)superView{
    [self hidePopupViewToView:superView animation:NO];
}

/**
 *  从父视图的window上移除弹出视图，有动画
 */
- (void)hidePopupViewToView:(UIView *)superView animation:(BOOL)animation{
    if (animation) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.popupView.frame;
            frame.origin.y = self.frame.size.height;
            self.popupView.frame = frame;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                self.coverView.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }];
    }else
    {
        [self removeFromSuperview];
    }
}

#pragma mark - 构建UI
// 创建并显示遮盖视图
- (void)createCoverViewIsAnimation:(BOOL)animation completion:(void(^)(void))completion{
    // 遮盖视图
    UIImageView *coverView = [[UIImageView alloc]initWithFrame:self.bounds];
    coverView.image = [UIImage imageNamed:@"icon_bgdack"];
    coverView.backgroundColor = [UIColor clearColor];
    coverView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCoverView:)];
    [coverView addGestureRecognizer:tapGesture];

    coverView.alpha = 0;
    //    coverView.image = [UIImage imageNamed:@""];
    [self addSubview:coverView];
    self.coverView = coverView;
    if (animation) {
        [UIView animateWithDuration:0.5 animations:^{
            coverView.alpha = 1;
        } completion:^(BOOL finished) {
            if(completion){
                completion();
            };
        }];
    }else{
        coverView.alpha = 1;
        if(completion){
            completion();
        };
    }
}

/**
 *  创建弹出视图的头部视图
 */
- (void)createHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.popupView.frame.size.width, 40)];
    // 头部视图的背景图
    UIImageView *headerBgImageView = [[UIImageView alloc] initWithFrame:headerView.bounds];
    headerBgImageView.image = [UIImage imageNamed:@"title-box_bg"];
    [headerView addSubview:headerBgImageView];
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, headerView.frame.size.height)];
    titleLabel.text = self.titleText;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithHexString:@"#313131"];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.backgroundColor = [UIColor clearColor];
    [headerView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    /**
     *  取消按钮
     */
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 7.5, 40, 25)];
    [cancelButton setBackgroundColor:self.cancelButtonColor];
    [cancelButton setTitleColor:[UIColor colorWithHexString:@"#313131"] forState:UIControlStateNormal];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setCornerRadius:15];
    [cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:cancelButton];
    self.cancelButton = cancelButton;
    self.cancelButton.hidden = !self.showCancelButton;
    
    // 确认按钮
    UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(headerView.frame.size.width - 70, 7.5, 60, 24)];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"icon_btnok"] forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    confirmButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:confirmButton];
    self.confirmButton = confirmButton;
    self.confirmButton.hidden = !self.showConfirmButton;
    
    [self.popupView addSubview:headerView];
    self.headerView = headerView;
}

#pragma mark - 重写setting方法

- (void)setShowCancelButton:(BOOL)showCancelButton
{
    _showCancelButton = showCancelButton;
    self.cancelButton.hidden = !showCancelButton;
}
- (void)setShowConfirmButton:(BOOL)showConfirmButton
{
    _showConfirmButton = showConfirmButton;
    self.confirmButton.hidden = !showConfirmButton;
}

- (void)setShowCoverView:(BOOL)showCoverView
{
    _showCoverView = showCoverView;
    self.coverView.hidden =  !showCoverView;
}
- (void)setTitleText:(NSString *)titleText
{
    _titleText = titleText;
    self.titleLabel.text = titleText;
}

#pragma mark - 事件
- (void)tapCoverView:(UITapGestureRecognizer *)sender{
    [self hidePopupViewToView:self.superview animation:YES];
}
- (void)cancelButtonClick:(UIButton *)sender{
    [self hidePopupViewToView:self.superview animation:YES];
}
- (void)confirmButtonClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(popupBaseViewDidConfirmButton:)]) {
        [self.delegate popupBaseViewDidConfirmButton:self];
    }
    [self hidePopupViewToView:self.superview animation:YES];
}
@end
