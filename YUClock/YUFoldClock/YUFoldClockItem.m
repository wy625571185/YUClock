//
//  YUFoldClockItem.m
//  翻页动画
//
//  Created by yu on 2019/8/5.
//  Copyright © 2019 yu. All rights reserved.
//

#import "YUFoldClockItem.h"
#import "YUFoldLabel.h"

@interface YUFoldClockItem () {
    NSInteger _lastLeftTime;
    NSInteger _lastRightTime;
    UIView *_line;
    BOOL _firstSetTime;
}

@property (nonatomic, strong) YUFoldLabel *leftLabel;

@property (nonatomic, strong) YUFoldLabel *rightLabel;

@property (nonatomic, strong) UIView *line;

@end

@implementation YUFoldClockItem

- (instancetype)init {
    if (self = [super init]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    [self addSubview:self.leftLabel];
    
    [self addSubview:self.rightLabel];
    
    [self addSubview:self.line];
    
    _lastLeftTime = -1;
    _lastRightTime = -1;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat labelW = CGRectGetWidth(self.bounds) / 2.0f;
    CGFloat labelH = CGRectGetHeight(self.bounds);
    
    self.leftLabel.frame = CGRectMake(0, 0, labelW, labelH);
    self.rightLabel.frame = CGRectMake(labelW, 0, labelW, labelH);
    
    self.layer.cornerRadius = CGRectGetHeight(self.bounds) / 10.0f;
    self.layer.masksToBounds = true;
    
    self.line.bounds = CGRectMake(0, 0, CGRectGetWidth(self.bounds), 5);
    self.line.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.0f, CGRectGetHeight(self.bounds) / 2.0f);
}

- (void)setTime:(NSInteger)time {
    _time = time;
    [self configLeftTimeLabel:time/10];
    [self configRightTimeLabel:time%10];
}

- (void)configLeftTimeLabel:(NSInteger)time {
    if (_lastLeftTime == time && _lastLeftTime != -1) {return;}
    _lastLeftTime = time;
    NSInteger current = 0;
    switch (self.type) {
        case YUClockItemTypeHour:
            current = time == 0 ? 2 : time - 1;
            break;
        case YUClockItemTypeMinute:
            current = time == 0 ? 5 : time - 1;
            break;
        case YUClockItemTypeSecond:
            current = time == 0 ? 5 : time - 1;
            break;
        default:
            break;
    }
    [_leftLabel updateTime:current nextTime:time];
}

- (void)configRightTimeLabel:(NSInteger)time {
    if (_lastRightTime == time && _lastRightTime != -1) {return;}
    _lastRightTime = time;
    NSInteger current = 0;
    switch (self.type) {
        case YUClockItemTypeHour:
            current = time == 0 ? 4 : time - 1;
            break;
        case YUClockItemTypeMinute:
            current = time == 0 ? 9 : time - 1;
            break;
        case YUClockItemTypeSecond:
            current = time == 0 ? 9 : time - 1;
            break;
        default:
            break;
    }
    [_rightLabel updateTime:current nextTime:time];
}

#pragma mark -
#pragma mark Setter
- (void)setFont:(UIFont *)font {
    _leftLabel.font = font;
    _rightLabel.font = font;
}

- (void)setTextColor:(UIColor *)textColor {
    _leftLabel.textColor = textColor;
    _rightLabel.textColor = textColor;
}

#pragma mark ========= lazy load =========
-(YUFoldLabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[YUFoldLabel alloc] init];
    }
    return _leftLabel;
}

-(YUFoldLabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[YUFoldLabel alloc] init];
    }
    return _rightLabel;
}

-(UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor blackColor];
    }
    return _line;
}

@end
