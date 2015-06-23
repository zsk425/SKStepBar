//
//  SKStepBar.m
//  SKStepBar
//
//  Created by zhaosk on 15/6/23.
//  Copyright (c) 2015年 zhaosk. All rights reserved.
//

#import "SKStepBar.h"
#import "SKStep.h"
#import <Masonry/Masonry.h>

@interface SKStepBar ()
@property (nonatomic) NSArray *steps;
@property (nonatomic) UIView *line;
@end

@implementation SKStepBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupViews];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews
{
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.top.equalTo(@10);
        make.height.equalTo(@2);
    }];
}

#pragma mark - Layout
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (CGSize)intrinsicContentSize
{
    SKStep *step = self.steps.firstObject;
    
    CGFloat height = UIViewNoIntrinsicMetric;
    if (step)
    {
        height = step.intrinsicContentSize.height;
    }
    
    return CGSizeMake(UIViewNoIntrinsicMetric, height);
}

- (void)tintColorDidChange
{
    [super tintColorDidChange];
    
    self.line.backgroundColor = self.tintColor;
}

#pragma mark - Helpers
- (UIView *)line
{
    if (!_line)
    {
        _line = [UIView new];
        _line.backgroundColor = self.tintColor;
    }
    
    return _line;
}

#pragma mark - Public methods
- (void)setTitles:(NSArray *)titles
{
    UIView *firstPaddingView = nil;
    UIView *previousView = nil;
    UIView *paddingView = nil;
    
    UIFont *font = [UIFont systemFontOfSize:12];
    NSMutableArray *steps = [NSMutableArray array];
    
    for (NSString *title in titles)
    {
        paddingView = [UIView new];
        paddingView.hidden = YES;
        [self addSubview:paddingView];
        if (firstPaddingView && previousView)
        {
            [paddingView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.width.height.equalTo(firstPaddingView);
                make.leading.equalTo(previousView.mas_trailing);
            }];
        }
        else
        {
            firstPaddingView = paddingView;
            
            [firstPaddingView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.leading.equalTo(self);
                make.height.equalTo(@1);
            }];
        }
        
        previousView = paddingView;
        
        SKStep *step = [SKStep new];
        step.title = title;
        step.font = font;
        [steps addObject:step];
        [self addSubview:step];
        [step mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(previousView.mas_trailing);
            make.top.equalTo(self);
        }];
        
        previousView = step;
    }
    
    if (previousView)
    {
        paddingView = [UIView new];
        paddingView.hidden = YES;
        [self addSubview:paddingView];
        [paddingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.width.height.equalTo(firstPaddingView);
            make.leading.equalTo(previousView.mas_trailing);
            make.trailing.equalTo(self);
        }];
    }
    
    SKStep *firstStep = steps.firstObject;
    if (firstStep)
    {
        firstStep.selected = YES;
        self.steps = steps;
    }
    
    [self invalidateIntrinsicContentSize];
}

- (NSInteger)selectedIndex
{
    __block NSInteger index = 0;
    [self.steps enumerateObjectsUsingBlock:^(SKStep *step, NSUInteger idx, BOOL *stop) {
        if (step.selected)
        {
            index = idx;
            *stop = YES;
        }
    }];
    
    return index;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    [self.steps enumerateObjectsUsingBlock:^(SKStep *step, NSUInteger idx, BOOL *stop) {
        step.selected = selectedIndex == idx;
    }];
}

- (void)setSelectedColor:(UIColor *)selectedColor
{
    _selectedColor = selectedColor;
    
    for (SKStep *step in self.steps)
    {
        step.selectedColor = selectedColor;
    }
}

@end
