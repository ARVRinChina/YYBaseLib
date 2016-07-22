//
//  MBProgressHUD+MBProgressHUD_Category.m
//  Lanove
//
//  Created by admin on 14/12/8.
//  Copyright (c) 2014年 terry.tgq. All rights reserved.
//

#import "MBProgressHUD+MBProgressHUD_Category.h"

@implementation MBProgressHUD (MBProgressHUD_Category)
+(void)showMessage:(NSString *)message{
    
    [[MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES] setLabelText:message];
}

+(void)hideMessage{
    
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

+(void)autoShowAndHideWithMessage:(NSString *)msg{
    
    [MBProgressHUD autoShowWithMsg:msg customView:[UIApplication sharedApplication].keyWindow];
    
}

@end
