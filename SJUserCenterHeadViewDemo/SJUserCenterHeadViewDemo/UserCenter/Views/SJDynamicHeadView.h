//
//  SJDynamicHeadView.h
//  SJUserCenterHeadViewDemo
//
//  Created by Jaesun on 16/8/25.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJDynamicHeadView : UIView

@property (nonatomic, strong) UIView *navBar;
@property (nonatomic, strong) UIImageView *imgView;

- (void)starWave;
- (void)stopWave;

@end
