//
//  HandleCrashTools.m
//  HFCrashGuard
//
//  Created by 刘洪飞 on 2021/6/5.
//

#import "HandleCrashTools.h"
#import "HandleCrashMacros.h"
#import <objc/runtime.h>

@implementation HandleCrashTools

// 类方法的交换
+ (void)exchangeClassMethod:(Class)anClass
                 method1Sel:(SEL)method1Sel
                 method2Sel:(SEL)method2Sel {
    Method method1 = class_getClassMethod(anClass, method1Sel);
    Method method2 = class_getClassMethod(anClass, method2Sel);
    method_exchangeImplementations(method1, method2);
}

// 对象方法的交换
+ (void)exchangeInstanceMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel {
    Method originalMethod = class_getInstanceMethod(anClass, method1Sel);
    Method swizzledMethod = class_getInstanceMethod(anClass, method2Sel);
    
    BOOL didAddMethod =
    class_addMethod(anClass, method1Sel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(anClass, method2Sel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

// 提示崩溃的信息(控制台输出、通知)
+ (void)noteErrorWithException:(NSException *)exception
                   defaultToDo:(NSString *)defaultToDo {
    // 堆栈数据
    NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
    // 获取在哪个类的哪个方法中实例化的数组  字符串格式 -[类名 方法名]  或者 +[类名 方法名]
    NSString *mainCallStackSymbolMsg = [HandleCrashTools getMainCallStackSymbolMessageWithCallStackSymbols:callStackSymbolsArr];
    
    if (mainCallStackSymbolMsg == nil) {
        mainCallStackSymbolMsg = @"崩溃方法定位失败，请您查看函数调用栈来排查错误原因";
    }
    
    // 异常的名字
    NSString *errorName = [NSString stringWithFormat:@"异常的名字：%@", exception.name];
    // 异常的原因
    NSString *errorReason = [NSString stringWithFormat:@"异常的原因：%@", exception.reason];
    // errorReason 可能为 -[__NSCFConstantString avoidCrashCharacterAtIndex:]: Range or index out of bounds
    // 将handleCrash去掉
    errorReason = [errorReason stringByReplacingOccurrencesOfString:@"avoidCrash" withString:@""];
    // 崩溃的位置
    NSString *errorPlace = [NSString stringWithFormat:@"崩溃的位置：%@", mainCallStackSymbolMsg];
    // 处理的方式
    NSString *errorToDo = [NSString stringWithFormat:@"处理的方式：%@", defaultToDo];
    
    NSString *logErrorMessage = [NSString stringWithFormat:@"\n%@\n\n%@\n%@\n%@\n%@", AvoidCrashSeparatorWithFlag, errorName, errorReason, errorPlace, errorToDo];
    logErrorMessage = [NSString stringWithFormat:@"%@\n\n%@",logErrorMessage,AvoidCrashSeparator];
    AvoidCrashLog(@"%@",logErrorMessage);
    
    // 请忽略下面的赋值，目的只是为了能顺利上传到cocoapods
    logErrorMessage = logErrorMessage;
    
    // 错误统计的字典
    NSDictionary *errorInfoDic = @{
                                   key_errorName        : errorName,
                                   key_errorReason      : errorReason,
                                   key_errorPlace       : errorPlace,
                                   key_defaultToDo      : defaultToDo,
                                   key_exception        : exception,
                                   key_callStackSymbols : callStackSymbolsArr
                                   };
    
    // 将错误信息放在字典里，用通知的形式发送出去
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:HandleCrashNotification object:nil userInfo:errorInfoDic];
    });
}

/**
 *  获取堆栈主要崩溃精简化的信息<根据正则表达式匹配出来>
 *
 *  @param callStackSymbols 堆栈主要崩溃信息
 *
 *  @return 堆栈主要崩溃精简化的信息
 */

+ (NSString *)getMainCallStackSymbolMessageWithCallStackSymbols:(NSArray<NSString *> *)callStackSymbols {
    // mainCallStackSymbolMsg的格式为   +[类名 方法名]  或者 -[类名 方法名]
    __block NSString *mainCallStackSymbolMsg = nil;
    
    // 匹配出来的格式为 +[类名 方法名]  或者 -[类名 方法名]
    NSString *regularExpStr = @"[-\\+]\\[.+\\]";
    
    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regularExpStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    for (int index = 2; index < callStackSymbols.count; index++) {
        NSString *callStackSymbol = callStackSymbols[index];
        
        [regularExp enumerateMatchesInString:callStackSymbol options:NSMatchingReportProgress range:NSMakeRange(0, callStackSymbol.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            if (result) {
                NSString *tempCallStackSymbolMsg = [callStackSymbol substringWithRange:result.range];
                
                // get className
                NSString *className = [tempCallStackSymbolMsg componentsSeparatedByString:@" "].firstObject;
                className = [className componentsSeparatedByString:@"["].lastObject;
                
                NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(className)];
                
                // filter category and system class
                if (![className hasSuffix:@")"] && bundle == [NSBundle mainBundle]) {
                    mainCallStackSymbolMsg = tempCallStackSymbolMsg;
                }
                *stop = YES;
            }
        }];
        
        if (mainCallStackSymbolMsg.length) {
            break;
        }
    }
    
    return mainCallStackSymbolMsg;
}

- (void)proxyMethod {}

@end
