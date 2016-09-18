//
//  SJWaveView.h
//  SJWaveView
//
//  Created by Jaesun on 16/8/26.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJWaveView : UIView

/**
 *  波浪的颜色
 */
@property (nonatomic, strong) UIColor *fillColor;

/**
 *  波浪的速度
 */
@property (nonatomic, assign) CGFloat speed;

/**
 *  波浪持续时间
 */
@property (nonatomic, assign) CGFloat duration;

- (void)starWave;

- (void)stopWave;

@end
