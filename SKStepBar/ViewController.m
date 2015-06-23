//
//  ViewController.m
//  SKStepBar
//
//  Created by zhaosk on 15/6/23.
//  Copyright (c) 2015年 zhaosk. All rights reserved.
//

#import "ViewController.h"
#import "SKStepBar.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet SKStepBar *stepBar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.stepBar.titles = @[@"Step 1",@"Step 2", @"Step 3",@"Step 4"];
    self.stepBar.tintColor = [UIColor lightGrayColor];
    self.stepBar.selectedColor = [UIColor orangeColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.stepBar.selectedIndex = 2;
    });
}

@end
