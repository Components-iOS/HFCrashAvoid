//
//  NSString+Handle.m
//  HFCrashGuard
//
//  Created by 刘洪飞 on 2021/6/6.
//

#import "NSString+Handle.h"
#import "HandleCrashTools.h"
#import "HandleCrashMacros.h"

@implementation NSString (Handle)

// 崩溃防护处理
+ (void)handleCrashExchangeMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class stringClass = NSClassFromString(@"__NSCFConstantString");
        
        // characterAtIndex
        [HandleCrashTools exchangeInstanceMethod:stringClass method1Sel:@selector(characterAtIndex:) method2Sel:@selector(avoidCrashCharacterAtIndex:)];
        
        // substringFromIndex
        [HandleCrashTools exchangeInstanceMethod:stringClass method1Sel:@selector(substringFromIndex:) method2Sel:@selector(avoidCrashSubstringFromIndex:)];
        
        // substringToIndex
        [HandleCrashTools exchangeInstanceMethod:stringClass method1Sel:@selector(substringToIndex:) method2Sel:@selector(avoidCrashSubstringToIndex:)];
        
        // substringWithRange:
        [HandleCrashTools exchangeInstanceMethod:stringClass method1Sel:@selector(substringWithRange:) method2Sel:@selector(avoidCrashSubstringWithRange:)];
        
        // stringByReplacingOccurrencesOfString:
        [HandleCrashTools exchangeInstanceMethod:stringClass method1Sel:@selector(stringByReplacingOccurrencesOfString:withString:) method2Sel:@selector(avoidCrashStringByReplacingOccurrencesOfString:withString:)];
        
        // stringByReplacingOccurrencesOfString:withString:options:range:
        [HandleCrashTools exchangeInstanceMethod:stringClass method1Sel:@selector(stringByReplacingOccurrencesOfString:withString:options:range:) method2Sel:@selector(avoidCrashStringByReplacingOccurrencesOfString:withString:options:range:)];
        
        // stringByReplacingCharactersInRange:withString:
        [HandleCrashTools exchangeInstanceMethod:stringClass method1Sel:@selector(stringByReplacingCharactersInRange:withString:) method2Sel:@selector(avoidCrashStringByReplacingCharactersInRange:withString:)];
    });
}

#pragma mark - characterAtIndex:

- (unichar)avoidCrashCharacterAtIndex:(NSUInteger)index {
    unichar characteristic;
    
    @try {
        characteristic = [self avoidCrashCharacterAtIndex:index];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnStrNil;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
    } @finally {
        return characteristic;
    }
}

#pragma mark - substringFromIndex:

- (NSString *)avoidCrashSubstringFromIndex:(NSUInteger)from {
    NSString *subString = nil;
    
    @try {
        subString = [self avoidCrashSubstringFromIndex:from];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
        subString = nil;
    } @finally {
        return subString;
    }
}

#pragma mark - substringToIndex

- (NSString *)avoidCrashSubstringToIndex:(NSUInteger)to {
    NSString *subString = nil;
    
    @try {
        subString = [self avoidCrashSubstringToIndex:to];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
        subString = nil;
    } @finally {
        return subString;
    }
}

#pragma mark - substringWithRange:

- (NSString *)avoidCrashSubstringWithRange:(NSRange)range {
    NSString *subString = nil;
    
    @try {
        subString = [self avoidCrashSubstringWithRange:range];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
        subString = nil;
    } @finally {
        return subString;
    }
}

#pragma mark - stringByReplacingOccurrencesOfString:

- (NSString *)avoidCrashStringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement {
    NSString *newStr = nil;
    
    @try {
        newStr = [self avoidCrashStringByReplacingOccurrencesOfString:target withString:replacement];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
        newStr = nil;
    } @finally {
        return newStr;
    }
}

#pragma mark - stringByReplacingOccurrencesOfString:withString:options:range:

- (NSString *)avoidCrashStringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange {
    NSString *newStr = nil;
    
    @try {
        newStr = [self avoidCrashStringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
        newStr = nil;
    } @finally {
        return newStr;
    }
}

#pragma mark - stringByReplacingCharactersInRange:withString:

- (NSString *)avoidCrashStringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {
    NSString *newStr = nil;
    
    @try {
        newStr = [self avoidCrashStringByReplacingCharactersInRange:range withString:replacement];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
        newStr = nil;
    } @finally {
        return newStr;
    }
}

@end
