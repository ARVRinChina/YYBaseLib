//
//  UIView+extensions.m
//  LoveShape
//
//  Created by admin on 13-10-8.
//  Copyright (c) 2013年 terry.tgq. All rights reserved.
//

#import "UIView+extensions.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (extensions)
//设置圆角
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    if([self isKindOfClass:[UIButton class]])
    {
        [(UIButton *)self setBackgroundImage:nil forState:UIControlStateNormal];
    }
}

//设置边框宽度、颜色
- (void)setBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
}

/**
 *  设置虚线边框
 *
 *  @param borderColor     边框的颜色
 *  @param lineDashPattern 虚线的段长和间隔，例：@[@4,@2]
 */
- (void)setDashedWithBorderColor:(UIColor *)borderColor lineDashPattern:(NSArray *)lineDashPattern{
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.strokeColor = borderColor.CGColor;
    borderLayer.fillColor = nil;
    borderLayer.lineDashPattern = lineDashPattern;
    [self.layer addSublayer:borderLayer];
    borderLayer.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    borderLayer.frame = self.bounds;
}

@end
