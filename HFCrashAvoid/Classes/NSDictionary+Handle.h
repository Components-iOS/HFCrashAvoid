//
//  NSDictionary+Handle.h
//  HFCrashGuard
//
//  Created by 刘洪飞 on 2021/6/5.
//

#import <Foundation/Foundation.h>
#import "HandleCrashProtocol.h"

@interface NSDictionary (Handle) <HandleCrashProtocol>

/**
 *  Can avoid crash method
 *
 *  1. NSDictionary的快速创建方式 NSDictionary *dict = @{@"frameWork" : @"AvoidCrash"}; // 这种创建方式其实调用的是2中的方法
 *  2. +(instancetype)dictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt
 *
 */

@end
