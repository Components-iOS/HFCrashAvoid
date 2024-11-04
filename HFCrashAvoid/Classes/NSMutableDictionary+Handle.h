//
//  NSMutableDictionary+Handle.h
//  HFCrashGuard
//
//  Created by 刘洪飞 on 2021/6/6.
//

#import <Foundation/Foundation.h>
#import "HandleCrashProtocol.h"

@interface NSMutableDictionary (Handle) <HandleCrashProtocol>

/**
 *  Can avoid crash method
 *
 *  1. - (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey
 *  2. - (void)removeObjectForKey:(id)aKey
 *
 */

@end
