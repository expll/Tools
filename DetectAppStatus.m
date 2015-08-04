//
//  DetectAppStatus.m
//  被删除之前发送通知
//
//  Created by Tiny on 15/7/27.
//  Copyright (c) 2015年 com.sadf. All rights reserved.
//

#import "DetectAppStatus.h"
#import "Tools.h"
#import <UIKit/UIKit.h>
#import <MobileInstallation/MobileInstallation.h>

@implementation DetectAppStatus


// 1: 存在    0： 不存在

+ (void)AppStatusWithBundleID:(NSString *)bundleid callback:(void (^)(int))callback
{


    if ([Tools isInstallIpa:bundleid]) {
        callback(1);
    } else {
        callback(0);
    }
}

static int preappstatus = -1;
+ (void)DetectAppUninstalled:(NSString *)bundleid notification:(void(^)())notification
{
    void(^callback)(int) = ^(int x){
        
        NSLog(@"应用状态： %d, preappstatus: %d", x, preappstatus);
        
        if (preappstatus == -1) {
            preappstatus = x;
        } else {
        
            if (preappstatus == 1 && x == 0) {
                NSLog(@"应用%@被卸载。", bundleid);
                notification();
                preappstatus = x;
            }
        }
        

    };
    NSArray *args = @[bundleid, callback];
    NSInvocation *myInvocation = [Tools InvocationWithSEL:@selector(AppStatusWithBundleID:callback:) OBJ:self Arguments:args];
    [[NSTimer scheduledTimerWithTimeInterval:2 invocation:myInvocation repeats:YES] fire];
    

}

@end
