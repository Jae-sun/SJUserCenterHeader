//
//  SJDynamicHeadView.m
//  SJUserCenterHeadViewDemo
//
//  Created by Jaesun on 16/8/25.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "SJDynamicHeadView.h"


#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@implementation SJDynamicHeadView {
    /**
     * 视图高度
     */
    CGFloat headHeight;
  
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        headHeight = frame.size.height;
        [self s_setupViews];
    }
    
    return  self;
}

- (void)s_setupViews {
    
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.imgView.image = [UIImage imageNamed:@"Cyuri03.jpg"];
    self.imgView.clipsToBounds = YES;
    self.imgView.userInteractionEnabled = YES;
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.imgView];

    self.navBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 64)];
    self.navBar.backgroundColor = [UIColor colorWithRed:41/255.0 green:85/255.0 blue:254/255.0 alpha:1];
    self.navBar.alpha = 0;
   [self addSubview:self.navBar];
    
    self.waveView = [[SJWaveView alloc] initWithFrame:CGRectMake(0, headHeight - 12, self.frame.size.width, 12)];
    [self addSubview:self.waveView];
       
}

@end
