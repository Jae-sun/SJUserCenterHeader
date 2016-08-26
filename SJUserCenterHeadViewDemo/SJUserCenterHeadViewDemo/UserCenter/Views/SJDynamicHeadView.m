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
    /**
     *  波的振幅
     */
    CGFloat waveAmplitude;
    /**
     *  波的传播周期 单位 s
     */
    CGFloat wavePeriod;
    /**
     *  波长
     */
    CGFloat waveLength;

    /**
     *  画线
     */
    CADisplayLink *waveDisplaylink;
    CAShapeLayer *shapeLayer;
    
    /**
     *  x轴偏移
     */
    CGFloat offsetX;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        headHeight = frame.size.height;
        wavePeriod = 1;
        waveLength = SCREEN_W;
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
       
}

- (void)starWave {
    
    waveAmplitude = 6.0;
    shapeLayer = [CAShapeLayer layer];
    [self.imgView.layer addSublayer:shapeLayer];
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    //【**波动画关键**】 一秒执行60次（算是CADisplayLink特性），即每一秒执行 setShapeLayerPath 方法60次
    waveDisplaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(setShapeLayerPath)];
    [waveDisplaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)setShapeLayerPath {
    
    // 振幅不断减小，波执行完后为0 （使波浪更逼真些）
    waveAmplitude -= 0.05; // 2s 后为0
   
    if (waveAmplitude < 0.1) {
        [self stopWave];
    }
    
    // 每次执行画的正玄线平移一小段距离 （SCREEN_W / 60 / wavePeriod，1s执行60次，传播周期为wavePeriod,所以每个波传播一个屏幕的距离） 从而形成波在传播的效果
    
    offsetX += (SCREEN_W / 60 / wavePeriod);
    shapeLayer.path = [[self currentWavePath] CGPath];
}


// UIBezierPath 画线
- (UIBezierPath *)currentWavePath {
    
    UIBezierPath *p = [UIBezierPath bezierPath];
    CGMutablePathRef path = CGPathCreateMutable();
   
    // 设置线宽
    p.lineWidth = 2.0;

    CGPathMoveToPoint(path, nil, 0, headHeight);
    CGFloat y = 0.0f;
    
    for (float x = 0.0f; x <= SCREEN_W; x++) {
        
        /**
         * *** 正玄波的基础知识  ***
         *
         *  f(x) = Asin(ωx+φ)+k
         *
         *  A    为振幅, 波在上下振动时的最大偏移
         *
         *  φ/w  为在x方向平移距离
         *
         *  k    y轴偏移，即波的振动中心线y坐标与x轴的偏移距离
         *
         *  2π/ω 即为波长，若波长为屏幕宽度即， SCREEN_W = 2π/ω, ω = 2π/SCREEN_W
         */

        y = waveAmplitude * sinf((2 * M_PI / waveLength) * (x + offsetX + waveLength / 12)) + headHeight - waveAmplitude;
        
        // A = waveAmplitude  w = (2 * M_PI / waveLength) φ = (waveLength / 12) / (2 * M_PI / waveLength) k = headHeight - waveAmplitude （注意：坐标轴是一左上角为原点的）
        CGPathAddLineToPoint(path, nil, x, y);
        
    }

    CGPathAddLineToPoint(path, nil, SCREEN_W, headHeight);
    CGPathCloseSubpath(path);
    p.CGPath = path;
    CGPathRelease(path);
    return p;
}

- (void)stopWave {
    
    [shapeLayer removeFromSuperlayer];
    [waveDisplaylink invalidate];
    waveDisplaylink = nil;
}

@end
