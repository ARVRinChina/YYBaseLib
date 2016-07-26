//
//  UIImage+UIImageScale.h
//  ImageDemo
//
//  Created by tianxia on 14-1-21.
//  Copyright (c) 2014年 zhangjiajia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(UIImageScale)
-(UIImage*)getSubImage:(CGRect)rect;
-(UIImage*)scaleToSize:(CGSize)size;
@end
