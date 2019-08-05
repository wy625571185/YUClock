//
//  YUFoldLabel.m
//  翻页动画
//
//  Created by yu on 2019/8/5.
//  Copyright © 2019 yu. All rights reserved.
//

#import "YUFoldLabel.h"
#import "UILabel+YUAdd.h"

static CGFloat YUNextLabelStartValue = 0.01;

@interface YUFoldLabel () {
    /*! NOTE: 刷新UI工具 */
    CADisplayLink *_link;
    /*! NOTE: 动画执行进度 */
    CGFloat _animateValue;
}

/*! NOTE: 当前时间label */
@property (nonatomic, strong) UILabel *timeLabel;
/*! NOTE: 翻转动画label */
@property (nonatomic, strong) UILabel *foldLabel;
/*! NOTE: 下一个时间label */
@property (nonatomic, strong) UILabel *nextLabel;
/*! NOTE: 放置label的容器 */
@property (nonatomic, strong) UIView *labelContainer;

@end

@implementation YUFoldLabel

- (instancetype)init {
    if (self = [super init]) {
        [self buildUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    /*! NOTE: 放置label的容器 */
    [self addSubview:self.labelContainer];
    
    /*! NOTE: 当前时间 */
    [self.labelContainer addSubview:self.timeLabel];
    
    /*! NOTE: 下一个时间 */
    [self.labelContainer addSubview:self.nextLabel];
    
    /*! NOTE: 翻转动画 */
    [self.labelContainer addSubview:self.foldLabel];
    
    /*! NOTE: 刷新UI工具 */
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateAnimateLabel)];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.labelContainer.frame = self.bounds;
    self.timeLabel.frame = self.labelContainer.bounds;
    self.nextLabel.frame = self.labelContainer.bounds;
    self.foldLabel.frame = self.labelContainer.bounds;
}

#pragma mark -
#pragma mark 默认label起始角度
- (CATransform3D)nextLabelStartTransform {
    CATransform3D t = CATransform3DIdentity;
    t.m34  = CGFLOAT_MIN;
    t = CATransform3DRotate(t,M_PI * YUNextLabelStartValue, -1, 0, 0);
    return t;
}

#pragma mark ========= 动画相关方法 =========
- (void)start {
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stop {
    [_link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)updateAnimateLabel {
    _animateValue += 2/60.0f;
    if (_animateValue >= 1) {
        [self stop];
        return;
    }
    CATransform3D t = CATransform3DIdentity;
    t.m34  = CGFLOAT_MIN;
    /*! NOTE: 绕x轴进行翻转 */
    t = CATransform3DRotate(t, M_PI*_animateValue, -1, 0, 0);
    if (_animateValue >= 0.5) {
        /*! NOTE: 当翻转到和屏幕垂直时，翻转y和z轴 */
        t = CATransform3DRotate(t, M_PI, 0, 0, 1);
        t = CATransform3DRotate(t, M_PI, 0, 1, 0);
    }
    _foldLabel.layer.transform = t;
    /*! NOTE: 当翻转到和屏幕垂直时，切换动画label的字 */
    _foldLabel.text = _animateValue >= 0.5 ? _nextLabel.text : _timeLabel.text;
    /*! NOTE: 当翻转到指定角度时，显示下一秒的时间 */
    _nextLabel.hidden = _animateValue <= YUNextLabelStartValue;
}

#pragma mark ========= Setter =========
- (void)setFont:(UIFont *)font {
    _timeLabel.font = font;
    _foldLabel.font = font;
    _nextLabel.font = font;
}

- (void)setTextColor:(UIColor *)textColor {
    _timeLabel.textColor = textColor;
    _foldLabel.textColor = textColor;
    _nextLabel.textColor = textColor;
}

- (void)updateTime:(NSInteger)time nextTime:(NSInteger)nextTime {
    _timeLabel.text = [NSString stringWithFormat:@"%zd",time];
    _foldLabel.text = [NSString stringWithFormat:@"%zd",time];
    _nextLabel.text = [NSString stringWithFormat:@"%zd",nextTime];
    _nextLabel.layer.transform = [self nextLabelStartTransform];
    _nextLabel.hidden = true;
    _animateValue = 0.0f;
    [self start];
}

#pragma mark ========= lozy load =========
-(UIView *)labelContainer {
    if (!_labelContainer) {
        _labelContainer = [[UIView alloc] init];
        _labelContainer.backgroundColor = [UIColor colorWithRed:46/255.0f green:43/255.0f blue:46/255.0f alpha:1];
    }
    return _labelContainer;
}

/*! NOTE: 当前时间 */
-(UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        [_timeLabel setLabel];
    }
    return _timeLabel;
}

/*! NOTE: 下一个时间 */
-(UILabel *)nextLabel {
    if (!_nextLabel) {
        _nextLabel = [[UILabel alloc] init];
        [_nextLabel setLabel];
        _nextLabel.hidden = true;
        /*! NOTE: 设置显示角度，为了能够显示上半部分，下半部分隐藏 */
        _nextLabel.layer.transform = [self nextLabelStartTransform];
    }
    return _nextLabel;
}

/*! NOTE: 翻转动画 */
-(UILabel *)foldLabel {
    if (!_foldLabel) {
        _foldLabel = [[UILabel alloc] init];
        [_foldLabel setLabel];
    }
    return _foldLabel;
}

@end
