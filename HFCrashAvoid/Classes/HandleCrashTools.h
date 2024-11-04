//
//  HandleCrashTools.h
//  HFCrashGuard
//
//  Created by 刘洪飞 on 2021/6/5.
//

#import <Foundation/Foundation.h>

@interface HandleCrashTools : NSObject

/**
 *  类方法的交换
 *
 *  @param anClass    哪个类
 *  @param method1Sel 方法1
 *  @param method2Sel 方法2
 */
+ (void)exchangeClassMethod:(Class)anClass
                 method1Sel:(SEL)method1Sel
                 method2Sel:(SEL)method2Sel;

/**
 *  对象方法的交换
 *
 *  @param anClass    哪个类
 *  @param method1Sel 方法1(原本的方法)
 *  @param method2Sel 方法2(要替换成的方法)
 */
+ (void)exchangeInstanceMethod:(Class)anClass
                    method1Sel:(SEL)method1Sel
                    method2Sel:(SEL)method2Sel;

/**
 *  提示崩溃的信息(控制台输出、通知)
 *
 *  @param exception    捕获到的异常
 *  @param defaultToDo  这个框架里默认的做法
 */
+ (void)noteErrorWithException:(NSException *)exception
                   defaultToDo:(NSString *)defaultToDo;

- (void)proxyMethod;

@end
