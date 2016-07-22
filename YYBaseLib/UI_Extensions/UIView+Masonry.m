//
//  UIView+Masonry.m
//  xlzx
//
//  Created by tony on 16/1/16.
//  Copyright © 2016年 tony. All rights reserved.
//

#import "UIView+Masonry.h"
#import "Masonry.h"

@implementation UIView (Masonry)

- (void)distributeSpacingHorizontallyWith:(NSArray *)views
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(views);
    }];
    
    NSMutableArray *spaces = [NSMutableArray arrayWithCapacity:views.count+1];
    for (int i=0; i<views.count+1; ++i) {
        UIView *v = [UIView new];
        [spaces addObject:v];
        [self addSubview:v];
        
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(v.mas_height);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    
    UIView *v0 = spaces[0];
    [v0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
    }];
    
    UIView *lastSpace = v0;
    for (int i=0; i<views.count; ++i) {
        UIView *view = views[i];
        UIView *space = spaces[i+1];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lastSpace.mas_right);
        }];
        
        [space mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_right);
            make.width.equalTo(v0);
        }];
        
        lastSpace = space;
    }
    
    [lastSpace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
    }];
}

-(void)distributeSpacingVerticallyWith:(NSArray *)views
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(views);
    }];
    
    NSMutableArray *spaces = [NSMutableArray arrayWithCapacity:views.count+1];
    for (int i=0; i<views.count+1; ++i) {
        UIView *v = [UIView new];
        [spaces addObject:v];
        [self addSubview:v];
        
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(v.mas_height);
            make.centerX.equalTo(self.mas_centerX);
        }];
    }
    
    UIView *v0 = spaces[0];
    [v0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
    }];
    
    UIView *lastSpace = v0;
    for (int i=0; i<views.count; ++i) {
        UIView *view = views[i];
        UIView *space = spaces[i+1];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastSpace.mas_bottom);
        }];
        
        [space mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_bottom);
            make.height.equalTo(v0);
        }];
        
        lastSpace = space;
    }
    
    [lastSpace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
    }];
}

@end
