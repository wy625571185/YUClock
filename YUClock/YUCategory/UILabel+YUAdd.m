//
//  UILabel+YUAdd.m
//  YUClock
//
//  Created by yu on 2019/8/5.
//  Copyright © 2019 yu. All rights reserved.
//

#import "UILabel+YUAdd.h"

@implementation UILabel (YUAdd)

/*! NOTE: 设置label */
-(void)setLabel {
    self.textAlignment = NSTextAlignmentCenter;
    self.textColor = [UIColor colorWithRed:186/255.0f green:183/255.0f blue:186/255.0f alpha:1];
    self.font = [UIFont fontWithName:@"AmericanTypewriter-CondensedBold" size:150];
    self.layer.masksToBounds = true;
    self.backgroundColor = [UIColor colorWithRed:46/255.0f green:43/255.0f blue:46/255.0f alpha:1];
}

@end
