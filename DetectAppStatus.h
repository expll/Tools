//
//  DetectAppStatus.h
//  被删除之前发送通知
//
//  Created by Tiny on 15/7/27.
//  Copyright (c) 2015年 com.sadf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetectAppStatus : NSObject

+ (void)DetectAppUninstalled:(NSString *)bundleid notification:(void(^)())notification;

@end
