//
//  MBProgressHUD+MBProgressHUD_Category.h
//  Lanove
//
//  Created by admin on 14/12/8.
//  Copyright (c) 2014年 terry.tgq. All rights reserved.
//

#import "MBProgressHUD.h"

#define MBProgressHUDShowText(text) [MBProgressHUD autoShowAndHideWithMessage:(text)]

@interface MBProgressHUD (MBProgressHUD_Category)

+(void)showMessage:(NSString *)message;

+(void)hideMessage;

+(void)autoShowAndHideWithMessage:(NSString *)msg;

@end
