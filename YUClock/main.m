//
//  main.m
//  YUClock
//
//  Created by yu on 2019/8/5.
//  Copyright © 2019 yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUAppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        [NBSAppAgent startWithAppID:@"dd5e0f9ce9cd4bcc93922a6382cfe306"];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([YUAppDelegate class]));
    }
}
