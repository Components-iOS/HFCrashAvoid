//
//  NSMutableAttributedString+Handle.m
//  HFCrashGuard
//
//  Created by 刘洪飞 on 2021/6/6.
//

#import "NSMutableAttributedString+Handle.h"
#import "HandleCrashTools.h"
#import "HandleCrashMacros.h"

@implementation NSMutableAttributedString (Handle)

// 崩溃防护处理
+ (void)handleCrashExchangeMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class NSConcreteMutableAttributedString = NSClassFromString(@"NSConcreteMutableAttributedString");
        
        // initWithString:
        [HandleCrashTools exchangeInstanceMethod:NSConcreteMutableAttributedString method1Sel:@selector(initWithString:) method2Sel:@selector(avoidCrashInitWithString:)];
        
        // initWithString:attributes:
        [HandleCrashTools exchangeInstanceMethod:NSConcreteMutableAttributedString method1Sel:@selector(initWithString:attributes:) method2Sel:@selector(avoidCrashInitWithString:attributes:)];
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
