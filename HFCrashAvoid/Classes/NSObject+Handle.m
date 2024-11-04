//
//  NSObject+Handle.m
//  HFCrashGuard
//
//  Created by 刘洪飞 on 2021/6/6.
//

#import "NSObject+Handle.h"
#import "HandleCrashTools.h"
#import "HandleCrashMacros.h"
#import "HandleCrashStubProxy.h"

@implementation NSObject (Handle)

+ (void)avoidCrashExchangeMethodIfDealWithNoneSel:(BOOL)ifDealWithNoneSel {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // setValue:forKey:
        [HandleCrashTools exchangeInstanceMethod:[self class] method1Sel:@selector(setValue:forKey:) method2Sel:@selector(avoidCrashSetValue:forKey:)];
        
        // setValue:forKeyPath:
        [HandleCrashTools exchangeInstanceMethod:[self class] method1Sel:@selector(setValue:forKeyPath:) method2Sel:@selector(avoidCrashSetValue:forKeyPath:)];
        
        // setValue:forUndefinedKey:
        [HandleCrashTools exchangeInstanceMethod:[self class] method1Sel:@selector(setValue:forUndefinedKey:) method2Sel:@selector(avoidCrashSetValue:forUndefinedKey:)];
        
        // setValuesForKeysWithDictionary:
        [HandleCrashTools exchangeInstanceMethod:[self class] method1Sel:@selector(setValuesForKeysWithDictionary:) method2Sel:@selector(avoidCrashSetValuesForKeysWithDictionary:)];
        
        // unrecognized selector sent to instance
        if (ifDealWithNoneSel) {
            [HandleCrashTools exchangeInstanceMethod:[self class] method1Sel:@selector(methodSignatureForSelector:) method2Sel:@selector(avoidCrashMethodSignatureForSelector:)];
            [HandleCrashTools exchangeInstanceMethod:[self class] method1Sel:@selector(forwardInvocation:) method2Sel:@selector(avoidCrashForwardInvocation:)];
        }
    });
}

#pragma mark - unrecognized selector sent to instance

static NSMutableArray *noneSelClassStrings;
static NSMutableArray *noneSelClassStringPrefixs;

+ (void)setupNoneSelClassStringsArr:(NSArray<NSString *> *)classStrings {
    if (noneSelClassStrings) {
        AvoidCrashLog(@"\n⚠️⚠️⚠️ HandleCrashWarnings:\n[AvoidCrash setupNoneSelClassStringsArr:]\n调用一此即可，多次调用会自动忽略后面的调用\n");
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        noneSelClassStrings = [NSMutableArray array];
        
        for (NSString *className in classStrings) {
            if ([className hasPrefix:@"UI"] == NO &&
                [className isEqualToString:NSStringFromClass([NSObject class])] == NO) {
                [noneSelClassStrings addObject:className];
            } else {
                AvoidCrashLog(@"\n⚠️⚠️⚠️ HandleCrashWarnings:\n[AvoidCrash setupNoneSelClassStringsArr:]\n会忽略UI开头的类和NSObject类(请使用NSObject的子类)\n");
            }
        }
    });
}

+ (void)setupNoneSelClassStringPrefixsArr:(NSArray<NSString *> *)classStringPrefixs {
    if (noneSelClassStringPrefixs) {
        AvoidCrashLog(@"\n⚠️⚠️⚠️ HandleCrashWarnings:\n[AvoidCrash setupNoneSelClassStringPrefixsArr:]\n调用一此即可，多次调用会自动忽略后面的调用\n");
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        noneSelClassStringPrefixs = [NSMutableArray array];
        
        for (NSString *classNamePrefix in classStringPrefixs) {
            if ([classNamePrefix hasPrefix:@"UI"] == NO &&
                [classNamePrefix hasPrefix:@"NS"] == NO) {
                [noneSelClassStringPrefixs addObject:classNamePrefix];
            } else {
                AvoidCrashLog(@"\n⚠️⚠️⚠️ HandleCrashWarnings:\n[AvoidCrash setupNoneSelClassStringPrefixsArr:]\n会忽略UI开头的类和NS开头的类\n若需要对NS开头的类防止”unrecognized selector sent to instance\n(比如NSArray),请使用setupNoneSelClassStringsArr\n");
            }
        }
    });
}

- (NSMethodSignature *)avoidCrashMethodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *ms = [self avoidCrashMethodSignatureForSelector:aSelector];
    BOOL flag = NO;
    
    if (ms == nil) {
        for (NSString *classStr in noneSelClassStrings) {
            if ([self isKindOfClass:NSClassFromString(classStr)]) {
                ms = [HandleCrashStubProxy instanceMethodSignatureForSelector:@selector(proxyMethod)];
                flag = YES;
                break;
            }
        }
    }
    
    if (flag == NO) {
        NSString *selfClass = NSStringFromClass([self class]);
        for (NSString *classStrPrefix in noneSelClassStringPrefixs) {
            if ([selfClass hasPrefix:classStrPrefix]) {
                ms = [HandleCrashStubProxy instanceMethodSignatureForSelector:@selector(proxyMethod)];
            }
        }
    }
    
    return ms;
}

- (void)avoidCrashForwardInvocation:(NSInvocation *)anInvocation {
    @try {
        [self avoidCrashForwardInvocation:anInvocation];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
    } @finally {
        
    }
}

#pragma mark - setValue:forKey:

- (void)avoidCrashSetValue:(id)value forKey:(NSString *)key {
    @try {
        [self avoidCrashSetValue:value forKey:key];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
    } @finally {
        
    }
}

#pragma mark - setValue:forKeyPath:

- (void)avoidCrashSetValue:(id)value forKeyPath:(NSString *)keyPath {
    @try {
        [self avoidCrashSetValue:value forKeyPath:keyPath];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
    } @finally {
        
    }
}

#pragma mark - setValue:forUndefinedKey:

- (void)avoidCrashSetValue:(id)value forUndefinedKey:(NSString *)key {
    @try {
        [self avoidCrashSetValue:value forUndefinedKey:key];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
    } @finally {
        
    }
}

#pragma mark - setValuesForKeysWithDictionary:

- (void)avoidCrashSetValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    @try {
        [self avoidCrashSetValuesForKeysWithDictionary:keyedValues];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
    } @finally {
        
    }
}

@end
