//
//  NSMutableArray+Handle.m
//  HFCrashGuard
//
//  Created by 刘洪飞 on 2021/6/5.
//

#import "NSMutableArray+Handle.h"
#import "HandleCrashTools.h"
#import "HandleCrashMacros.h"

@implementation NSMutableArray (Handle)

// 崩溃防护处理
+ (void)handleCrashExchangeMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class arrayMClass = NSClassFromString(@"__NSArrayM");
        
        // objectAtIndex:
        [HandleCrashTools exchangeInstanceMethod:arrayMClass method1Sel:@selector(objectAtIndex:) method2Sel:@selector(avoidCrashObjectAtIndex:)];
        
        // objectAtIndexedSubscript
        if (AvoidCrashIsiOS(11.0)) {
            [HandleCrashTools exchangeInstanceMethod:arrayMClass method1Sel:@selector(objectAtIndexedSubscript:) method2Sel:@selector(avoidCrashObjectAtIndexedSubscript:)];
        }
        
        // setObject:atIndexedSubscript:
        [HandleCrashTools exchangeInstanceMethod:arrayMClass method1Sel:@selector(setObject:atIndexedSubscript:) method2Sel:@selector(avoidCrashSetObject:atIndexedSubscript:)];
        
        // removeObjectAtIndex:
        [HandleCrashTools exchangeInstanceMethod:arrayMClass method1Sel:@selector(removeObjectAtIndex:) method2Sel:@selector(avoidCrashRemoveObjectAtIndex:)];
        
        // insertObject:atIndex:
        [HandleCrashTools exchangeInstanceMethod:arrayMClass method1Sel:@selector(insertObject:atIndex:) method2Sel:@selector(avoidCrashInsertObject:atIndex:)];
        
        // getObjects:range:
        [HandleCrashTools exchangeInstanceMethod:arrayMClass method1Sel:@selector(getObjects:range:) method2Sel:@selector(avoidCrashGetObjects:range:)];
    });
}

#pragma mark - get object from array

- (void)avoidCrashSetObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    @try {
        [self avoidCrashSetObject:obj atIndexedSubscript:idx];
    } @catch (NSException *exception) {
        [HandleCrashTools noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    } @finally {
        
    }
}

#pragma mark - removeObjectAtIndex:

- (void)avoidCrashRemoveObjectAtIndex:(NSUInteger)index {
    @try {
        [self avoidCrashRemoveObjectAtIndex:index];
    } @catch (NSException *exception) {
        [HandleCrashTools noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    } @finally {
        
    }
}

#pragma mark - set方法

- (void)avoidCrashInsertObject:(id)anObject atIndex:(NSUInteger)index {
    @try {
        [self avoidCrashInsertObject:anObject atIndex:index];
    } @catch (NSException *exception) {
        [HandleCrashTools noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    } @finally {
        
    }
}

#pragma mark - objectAtIndex:

- (id)avoidCrashObjectAtIndex:(NSUInteger)index {
    id object = nil;
    
    @try {
        object = [self avoidCrashObjectAtIndex:index];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
    } @finally {
        return object;
    }
}

#pragma mark - objectAtIndexedSubscript:

- (id)avoidCrashObjectAtIndexedSubscript:(NSUInteger)idx {
    id object = nil;
    
    @try {
        object = [self avoidCrashObjectAtIndexedSubscript:idx];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
    } @finally {
        return object;
    }
}

#pragma mark - getObjects:range:

- (void)avoidCrashGetObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    @try {
        [self avoidCrashGetObjects:objects range:range];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
    } @finally {
        
    }
}

@end
