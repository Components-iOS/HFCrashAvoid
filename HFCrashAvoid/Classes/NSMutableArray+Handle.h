//
//  NSMutableArray+Handle.h
//  HFCrashGuard
//
//  Created by 刘洪飞 on 2021/6/5.
//

#import <Foundation/Foundation.h>
#import "HandleCrashProtocol.h"

@interface NSMutableArray (Handle) <HandleCrashProtocol>

/**
 *  Can avoid crash method
 *
 *  1. - (id)objectAtIndex:(NSUInteger)index
 *  2. - (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx
 *  3. - (void)removeObjectAtIndex:(NSUInteger)index
 *  4. - (void)insertObject:(id)anObject atIndex:(NSUInteger)index
 *  5. - (void)getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range
 */

@end
