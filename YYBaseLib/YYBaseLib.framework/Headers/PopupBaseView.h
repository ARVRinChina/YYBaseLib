//
//  PopupBaseView.h
//  xlzx
//
//  Created by 银羽网络 on 16/1/28.
//  Copyright © 2016年 tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopupBaseView;

@protocol PopupBaseViewDelegate <NSObject>

@optional
/**
 *  自定义弹出视图
 */
- (UIView *)popupViewToPopupBaseView:(PopupBaseView *)popupBaseView;

/**
 *  点击确定按钮
 */
- (void)popupBaseViewDidConfirmButton:(PopupBaseView *)popupBaseView;

@end

@interface PopupBaseView : UIView

/**
 *  加载弹出视图的工厂方法
 */
+ (instancetype)popupView;

- (instancetype)initWithDelegate:(id)delegate;

/**
 *  显示弹出视图到父视图的window上，没有动画效果
 */
- (void)showPopupViewToView:(UIView *)superView;

/**
 *  显示弹出视图到父视图的window上，有动画效果
 */
- (void)showPopupViewToView:(UIView *)superView animation:(BOOL)animation;

/**
 *  从父视图的window上移除弹出视图，没有动画
 */
- (void)hidePopupViewToView:(UIView *)superView;

/**
 *  从父视图的window上移除弹出视图，有动画
 */
- (void)hidePopupViewToView:(UIView *)superView animation:(BOOL)animation;


@property (nonatomic, weak) id<PopupBaseViewDelegate> delegate;

/**
 *  显示遮盖背景图,默认为YES
 */
@property (nonatomic, assign) BOOL showCoverView;

/**
 *  显示取消按钮，默认为YES
 */
@property (nonatomic, assign) BOOL showCancelButton;

/**
 *  显示确定按钮，默认为YES
 */
@property (nonatomic, assign) BOOL showConfirmButton;

/**
 *  取消按钮的颜色
 */
@property (nonatomic, strong) UIColor *cancelButtonColor;

/**
 *  确定按钮的颜色
 */
//@property (nonatomic, strong) UIColor *confirmButtonColor;

/**
 *  取消按钮
 */
@property (nonatomic, weak) UIButton *cancelButton;

/**
 *  确定按钮
 */
@property (nonatomic, weak) UIButton *confirmButton;

/**
 *  标题文字
 */
@property (nonatomic, copy) NSString *titleText;


/**
 *  弹出视图距离屏幕左右两边的间距，默认是10
 */
@property (nonatomic, assign) CGFloat marginLength;


@end
