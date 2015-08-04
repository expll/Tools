//
//  Tools.h
//  测试启动流程
//
//  Created by Tiny on 15/7/24.
//  Copyright (c) 2015年 com.sadf. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Tools : NSObject
+(void)launchApp:(NSString *)bundleid;
+ (NSInvocation *)InvocationWithSEL:(SEL)s OBJ:(id)o Arguments:(NSArray *)args;
+(BOOL) isInstallIpa:(NSString *)bundleID;


@end
