//
//  WaveProgressView.m
//  wave
//
//  Created by qipai on 2018/3/16.
//  Copyright © 2018年 czl. All rights reserved.
//

#import "WaveProgressView.h"
#import "ZLMath.h"

@interface WaveProgressView()
{
    CGFloat a ;
    CGFloat b ;
    BOOL boolValue;
}

@property(nonatomic,strong)NSTimer* timerWave;

@end

@implementation WaveProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _innerColor = [UIColor blueColor];
        _outsideColor = [UIColor blackColor];
        _progress = 0.5f;
        
        a = 1.5;
        b = 0;
        boolValue = false;
        
        self.timerWave = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(onWave) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)onWave {
    a = boolValue ? (a + 0.01) : (a - 0.01);
    if (a <= 1) {
        boolValue = true;
    } else {
        boolValue = false;
    }
    b = b + 0.1;
    [self setNeedsDisplay];
}

- (void)dealloc {
    if (self.timerWave) {
        [self.timerWave invalidate];
        self.timerWave = nil;
    }
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor whiteColor] set];
    CGContextFillRect(context, rect);
    
    CGMutablePathRef outPath = CGPathCreateMutable();
    CGContextSetLineWidth(context, 2);
    CGPoint outPoints[] = {
        CGPointMake(0, 0),
        CGPointMake(rect.size.width, 0),
        CGPointMake(rect.size.width-(rect.size.width/5.0), rect.size.height),
        CGPointMake(rect.size.width/5.0, rect.size.height),
        CGPointMake(0, 0),
    };
    CGPathAddLines(outPath, NULL, outPoints, 5);
    CGContextAddPath(context, outPath);
    [_outsideColor set];
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(outPath);
    
    CGMutablePathRef innerPath = CGPathCreateMutable();
    CGContextSetLineWidth(context, 1);
    CGContextSetFillColorWithColor(context, _innerColor.CGColor);
    
    float height = _progress*rect.size.height;
    CGFloat angle1 = angleBetweenLines(outPoints[0],CGPointMake(0, rect.size.height),outPoints[0],outPoints[3]);
    CGFloat x1 = (rect.size.height-height) * tanf(degreesToRadians(angle1));
    CGFloat angle2 = angleBetweenLines(outPoints[1],CGPointMake(rect.size.width, rect.size.height),outPoints[1],outPoints[2]);
    CGFloat x2 = (rect.size.height-height) * tanf(degreesToRadians(angle2));
    x2 = rect.size.width-x2;
    CGFloat y1 = rect.size.height-height;
    
    CGPathMoveToPoint(innerPath, nil, x1, y1);
    for (int i=x1; i<=x2; i++) {
        CGFloat y = a * sin( i/180.0 * M_PI + 8 * b/M_PI) * 5 + height;
        CGPathAddLineToPoint(innerPath, nil, i, y);
    }

    CGPathAddLineToPoint(innerPath, nil, outPoints[2].x, outPoints[2].y);
    CGPathAddLineToPoint(innerPath, nil, outPoints[3].x, outPoints[3].y);
    CGPathAddLineToPoint(innerPath, nil, outPoints[0].x, outPoints[0].y);

    CGContextAddPath(context, innerPath);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    [super drawRect:rect];
}

@end
