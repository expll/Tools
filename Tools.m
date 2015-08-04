//
//  Tools.m
//  测试启动流程
//
//  Created by Tiny on 15/7/24.
//  Copyright (c) 2015年 com.sadf. All rights reserved.
//

#import "Tools.h"
#import <UIKit/UIKit.h>
#import <SpringBoardServices/SpringBoardServices.h>
#import <MobileInstallation/MobileInstallation.h>
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

+ (NSInvocation *)InvocationWithSEL:(SEL)s OBJ:(id)o Arguments:(NSArray *)args
{
    SEL mySelector = s;
    struct objc_object *a = (__bridge struct objc_object *)(o);
    NSMethodSignature * sig = [a->isa instanceMethodSignatureForSelector: mySelector];
    
    NSInvocation * myInvocation = [NSInvocation invocationWithMethodSignature: sig];
    [myInvocation setTarget: o];
    [myInvocation setSelector: mySelector];
    
    
    
    for (int i = 0; i < args.count; i++) {
        id arg = args[i];
        [myInvocation setArgument: &arg atIndex: i+2];
    }
    
    [myInvocation retainArguments];
    
    return myInvocation;
    
}

+(BOOL) isInstallIpa:(NSString *)bundleID
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f)
    {
        Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
        NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
        NSArray *array = [workspace performSelector:@selector(allInstalledApplications)];
        
        for (int i = 0; i < array.count; i ++)
        {
            Class LSApplicationProxy_class = [array objectAtIndex:i];
            NSString *bundleIdString = [LSApplicationProxy_class performSelector:@selector(applicationIdentifier)];
            
            if ([bundleIdString isEqualToString:bundleID])
            {
                return YES;
            }
        }
    }else
    {
        NSDictionary *options = @{@"ApplicationType": @"Any",
                                  @"BundleIDs":bundleID};
        
        NSDictionary *datas =  (__bridge_transfer  NSDictionary*)MobileInstallationLookup((__bridge CFDictionaryRef)options);
        if (datas.count > 0) {
            return YES;
        }else
            return NO;
        
    }
    
    
    return NO;
    
    
}


@end
