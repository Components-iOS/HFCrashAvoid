//
//  NSMutableDictionary+Handle.m
//  HFCrashGuard
//
//  Created by 刘洪飞 on 2021/6/6.
//

#import "NSMutableDictionary+Handle.h"
#import <objc/runtime.h>
#import "HandleCrashTools.h"
#import "HandleCrashMacros.h"

@implementation NSMutableDictionary (Handle)

// 崩溃防护处理
+ (void)handleCrashExchangeMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class dictionaryM = NSClassFromString(@"__NSDictionaryM");
        
        // setObject:forKey:
        [HandleCrashTools exchangeInstanceMethod:dictionaryM method1Sel:@selector(setObject:forKey:) method2Sel:@selector(avoidCrashSetObject:forKey:)];
        
        // setObject:forKeyedSubscript:
        if (AvoidCrashIsiOS(11.0)) {
            [HandleCrashTools exchangeInstanceMethod:dictionaryM method1Sel:@selector(setObject:forKeyedSubscript:) method2Sel:@selector(avoidCrashSetObject:forKeyedSubscript:)];
        }
                
        // removeObjectForKey:
        [HandleCrashTools exchangeInstanceMethod:dictionaryM method1Sel:@selector(removeObjectForKey:) method2Sel:@selector(avoidCrashRemoveObjectForKey:)];
    });
}

#pragma mark - setObject:forKey:

- (void)avoidCrashSetObject:(id)anObject forKey:(id<NSCopying>)aKey {
    @try {
        [self avoidCrashSetObject:anObject forKey:aKey];
    } @catch (NSException *exception) {
        [HandleCrashTools noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    } @finally {
        
    }
}

#pragma mark - setObject:forKeyedSubscript:

- (void)avoidCrashSetObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    @try {
        [self avoidCrashSetObject:obj forKeyedSubscript:key];
    } @catch (NSException *exception) {
        [HandleCrashTools noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    } @finally {
        
    }
}

#pragma mark - removeObjectForKey:

- (void)avoidCrashRemoveObjectForKey:(id)aKey {
    @try {
        [self avoidCrashRemoveObjectForKey:aKey];
    } @catch (NSException *exception) {
        [HandleCrashTools noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    } @finally {
        
    }
}

@end
