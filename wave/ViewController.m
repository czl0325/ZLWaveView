//
//  ViewController.m
//  wave
//
//  Created by qipai on 2018/3/16.
//  Copyright © 2018年 czl. All rights reserved.
//

#import "ViewController.h"
#import "WaveProgressView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    WaveProgressView *progress = [[WaveProgressView alloc]initWithFrame:CGRectMake(50, 50, 200, 200)];
    [self.view addSubview:progress];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
