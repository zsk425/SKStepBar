//
//  SKStep.m
//  SKStepBar
//
//  Created by zhaosk on 15/6/23.
//  Copyright (c) 2015年 zhaosk. All rights reserved.
//

#import "SKStep.h"
#import <Masonry/Masonry.h>

//Layout
static CGFloat const kDefaultVerticalSpacing = 8.0;
static CGFloat const kDotRadius = 10.0;

@interface SKStep ()
@property (nonatomic) UIView *dot;
@property (nonatomic) UILabel *label;
@end

@implementation SKStep

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
    _selectedColor = [UIColor orangeColor];
    
    [self addSubview:self.dot];
    [self addSubview:self.label];
}

#pragma mark - Layout
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (CGSize)intrinsicContentSize
{
    CGSize labelSize = self.label.intrinsicContentSize;
    
    CGFloat width = MAX(kDotRadius * 2, labelSize.width);
    
    return CGSizeMake(width, labelSize.height + kDefaultVerticalSpacing + kDotRadius * 2);
}

- (void)updateConstraints
{
    [self.dot mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.centerX.equalTo(self);
        make.width.height.equalTo(@(kDotRadius * 2));
    }];
    
    [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dot.mas_bottom).with.offset(8);
        make.centerX.equalTo(self);
    }];
    
    [super updateConstraints];
}

#pragma mark - Appearance
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected)
    {
        self.dot.backgroundColor = self.label.textColor = self.selectedColor;
    }
    else
    {
        self.dot.backgroundColor = self.label.textColor = self.tintColor;
    }
}

- (void)tintColorDidChange
{
    [super tintColorDidChange];
    
    if (!self.selected)
    {
        self.selected = NO;
    }
}

#pragma mark - Public methods
- (void)setFont:(UIFont *)font
{
    _font = font;
    if (_label)
    {
        _label.font = _font;
    }
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    if (_label)
    {
        _label.text = title;
        [self invalidateIntrinsicContentSize];
    }
}

#pragma mark - Helpers
- (void)setSelectedColor:(UIColor *)selectedColor
{
    _selectedColor = selectedColor;
    
    if (self.selected)
    {
        self.dot.backgroundColor = self.label.textColor = selectedColor;
    }
}

- (UIView *)dot
{
    if (!_dot)
    {
        _dot = [UIView new];
        _dot.translatesAutoresizingMaskIntoConstraints = NO;
        _dot.layer.cornerRadius = kDotRadius;
        _dot.backgroundColor = self.tintColor;
        _dot.clipsToBounds = YES;
    }
    
    return _dot;
}

- (UILabel *)label
{
    if (!_label)
    {
        _label = [UILabel new];
        _label.translatesAutoresizingMaskIntoConstraints = NO;
        if (!_font)
        {
            _label.font = _font;
            _label.textColor = self.tintColor;
            _label.textAlignment = NSTextAlignmentCenter;
        }
    }
    
    return _label;
}

@end
