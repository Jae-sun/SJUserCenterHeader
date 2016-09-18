//
//  SJWaveView.m
//  SJWaveView
//
//  Created by Jaesun on 16/8/26.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "SJWaveView.h"

@interface SJWaveView()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) CADisplayLink *displaylink;

@property (nonatomic, assign) CGFloat wave_W;
@property (nonatomic, assign) CGFloat wave_H;

@property (nonatomic, assign) CGFloat waveAmplitude;
@property (nonatomic, assign) CGFloat offsetX;



@end

@implementation SJWaveView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.wave_W = frame.size.width;
        self.wave_H = frame.size.height;
      
        [self s_setupViews];
        
    }
    return  self;
}

- (void)s_setupViews {
    
    self.backgroundColor = [UIColor clearColor];
}

-(void)starWave {
    //self.backgroundColor = [UIColor yellowColor];
    self.waveAmplitude = 0.5 * self.wave_H;
    
    // 给视图添加ShapeLayer
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.borderWidth = 1; // 线宽
//    self.shapeLayer.strokeColor = [UIColor redColor].CGColor; // 线的颜色
    self.shapeLayer.fillColor = [UIColor whiteColor].CGColor; // 填充色
    [self.layer addSublayer:self.shapeLayer];
    
    //【**波动画关键**】 一秒执行60次（算是CADisplayLink特性），即每一秒执行 setShapeLayerPath 方法60次
    self.displaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(setShapeLayerPath)];
    [self.displaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

// 设置正玄线路径
- (void)setShapeLayerPath {
    
    self.offsetX += (self.wave_W / 60);
    
    self.waveAmplitude -= 0.05;
    
    if (self.waveAmplitude < 0.1) {
        [self stopWave];
    }
    self.shapeLayer.path = [self sineBezierPath].CGPath;
}

/**
 *  画正玄线
 *
 *  @return UIBezierPath 对象
 */
- (UIBezierPath *)sineBezierPath {
    
    UIBezierPath *path = [UIBezierPath bezierPath];

    [path moveToPoint:CGPointMake(0, self.wave_H)];
   
    CGFloat y = 0.0f;
    for (float x = 0.0f; x <= self.wave_W; x++) {
        
        y = self.waveAmplitude * sinf((2 * M_PI / self.wave_W) * (x + self.offsetX)) + self.wave_H - self.waveAmplitude;
       
        [path addLineToPoint:CGPointMake(x, y)];
        
    }
    [path addLineToPoint:CGPointMake(self.wave_W, self.wave_H)];
    [path closePath];
    return path;
}

/**
 *  停止动画
 */
- (void)stopWave {

    [self.displaylink invalidate];
    [self.shapeLayer removeFromSuperlayer];
}



@end
