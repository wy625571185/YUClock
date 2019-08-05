//
//  YUMainController.m
//  YUClock
//
//  Created by yu on 2019/8/5.
//  Copyright © 2019 yu. All rights reserved.
//

#import "YUMainController.h"
#import "YUFoldClock.h"

@interface YUMainController () {
    NSTimer *_timer;
}

@property (nonatomic, strong) YUFoldClock *foldClock;

@end

@implementation YUMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.foldClock];
    
    /*! NOTE: 定时器 */
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimeLabel) userInfo:nil repeats:true];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.foldClock.frame = self.view.bounds;
}

- (void)updateTimeLabel {
    self.foldClock.date = [NSDate date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ========= lazy load =========
-(YUFoldClock *)foldClock {
    if (!_foldClock) {
        _foldClock = [[YUFoldClock alloc] init];
        _foldClock.frame = self.view.bounds;
        _foldClock.date = [NSDate date];
    }
    return _foldClock;
}

@end
