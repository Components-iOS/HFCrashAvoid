//
//  NSAttributedString+Handle.m
//  HFCrashGuard
//
//  Created by 刘洪飞 on 2021/6/6.
//

#import "NSAttributedString+Handle.h"
#import "HandleCrashTools.h"
#import "HandleCrashMacros.h"

@implementation NSAttributedString (Handle)

// 崩溃防护处理
+ (void)handleCrashExchangeMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class NSConcreteAttributedString = NSClassFromString(@"NSConcreteAttributedString");
        
        // initWithString:
        [HandleCrashTools exchangeInstanceMethod:NSConcreteAttributedString method1Sel:@selector(initWithString:) method2Sel:@selector(avoidCrashInitWithString:)];
        
        // initWithAttributedString
        [HandleCrashTools exchangeInstanceMethod:NSConcreteAttributedString method1Sel:@selector(initWithAttributedString:) method2Sel:@selector(avoidCrashInitWithAttributedString:)];
        
        // initWithString:attributes:
        [HandleCrashTools exchangeInstanceMethod:NSConcreteAttributedString method1Sel:@selector(initWithString:attributes:) method2Sel:@selector(avoidCrashInitWithString:attributes:)];
    });
}

#pragma mark - initWithString:

- (instancetype)avoidCrashInitWithString:(NSString *)str {
    id object = nil;
    
    @try {
        object = [self avoidCrashInitWithString:str];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
    } @finally {
        return object;
    }
}

#pragma mark - initWithAttributedString

- (instancetype)avoidCrashInitWithAttributedString:(NSAttributedString *)attrStr {
    id object = nil;
    
    @try {
        object = [self avoidCrashInitWithAttributedString:attrStr];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
    } @finally {
        return object;
    }
}

#pragma mark - initWithString:attributes:

- (instancetype)avoidCrashInitWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs {
    id object = nil;
    
    @try {
        object = [self avoidCrashInitWithString:str attributes:attrs];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
    } @finally {
        return object;
    }
}

@end
