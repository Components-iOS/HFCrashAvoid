//
//  NSArray+Handle.h
//  HFCrashGuard
//
//  Created by 刘洪飞 on 2021/6/5.
//

#import <Foundation/Foundation.h>
#import "HandleCrashProtocol.h"

@interface NSArray (Handle) <HandleCrashProtocol>

/**
 *  Can handle crash method
 *
 *  1. NSArray的快速创建方式 NSArray *array = @[@"", @""];  // 这种创建方式其实调用的是2中的方法
 *  2. +(instancetype)arrayWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt
 *  3. - (id)objectAtIndex:(NSUInteger)index
 *  4. - (void)getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range
 */

@end
