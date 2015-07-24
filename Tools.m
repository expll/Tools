//
//  Tools.m
//  测试启动流程
//
//  Created by Tiny on 15/7/24.
//  Copyright (c) 2015年 com.sadf. All rights reserved.
//

#import "Tools.h"
#import <UIKit/UIKit.h>
#import "LSApplicationWorkspace.h"

@implementation Tools



+(void)launchApp:(NSString *)bundleid
{
    Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
    LSApplicationWorkspace *workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
    
    if ([workspace respondsToSelector:@selector(openApplicationWithBundleID:)]) {
        Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
        LSApplicationWorkspace *workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
        [workspace openApplicationWithBundleID:bundleid];
    }
    else
    {
        // 需要权限： com.apple.springboard.launchapplications : YES
        CFStringRef bundleRef = (__bridge CFStringRef)bundleid;
        int ret = SBSLaunchApplicationWithIdentifier(bundleRef, NO);
        NSLog(@"启动程序 ret:%d", ret);
    }
    
    
}

@end
