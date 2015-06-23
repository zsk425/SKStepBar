//
//  SKStepBar.h
//  SKStepBar
//
//  Created by zhaosk on 15/6/23.
//  Copyright (c) 2015年 zhaosk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKStepBar : UIView
/**
 *  NSArray of NSString
 */
@property (nonatomic) NSArray *titles;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic) UIColor *selectedColor;
@end
