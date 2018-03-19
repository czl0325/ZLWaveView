//
//  WaveProgressView.h
//  wave
//
//  Created by qipai on 2018/3/16.
//  Copyright © 2018年 czl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaveProgressView : UIView

@property(nonatomic,strong)UIColor *innerColor;
@property(nonatomic,strong)UIColor *outsideColor;
@property(nonatomic,assign)float progress;

@end
