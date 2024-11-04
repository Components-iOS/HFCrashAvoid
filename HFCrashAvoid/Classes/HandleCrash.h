//
//  HandleCrash.h
//  HFCrashGuard
//
//  Created by 刘洪飞 on 2021/6/4.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "HandleCrashStubProxy.h"
#import "HandleCrashMacros.h"

// 分类
#import "NSObject+Handle.h"
#import "NSArray+Handle.h"
#import "NSMutableArray+Handle.h"
#import "NSDictionary+Handle.h"
#import "NSMutableDictionary+Handle.h"
#import "NSString+Handle.h"
#import "NSMutableString+Handle.h"
#import "NSAttributedString+Handle.h"
#import "NSMutableAttributedString+Handle.h"

@interface HandleCrash : NSObject

/**
 *  开始生效.你可以在AppDelegate的didFinishLaunchingWithOptions方法中调用becomeEffective方法
 *  【默认不开启  对”unrecognized selector sent to instance”防止崩溃的处理】
 *
 *  这是全局生效，若你只需要部分生效，你可以单个进行处理，比如:
 *  [NSArray avoidCrashExchangeMethod];
 *  [NSMutableArray avoidCrashExchangeMethod];
 *  .................
 *  .................
 *
 */
+ (void)becomeEffective;

/**
 *  相比于becomeEffective，增加
 *  对”unrecognized selector sent to instance”防止崩溃的处理
 *
 *  但是必须配合:
 *            setupClassStringsArr:和
 *            setupNoneSelClassStringPrefixsArr
 *            这两个方法可以同时使用
 */
+ (void)makeAllEffective;

/**
 *  初始化一个需要防止”unrecognized selector sent to instance”的崩溃的类名数组
 *  ⚠️不可将@"NSObject"加入classStrings数组中
 *  ⚠️不可将UI前缀的字符串加入classStrings数组中
 */
+ (void)setupNoneSelClassStringsArr:(NSArray<NSString *> *)classStrings;

/**
 *  初始化一个需要防止”unrecognized selector sent to instance”的崩溃的类名前缀的数组
 *  ⚠️不可将UI前缀的字符串(包括@"UI")加入classStringPrefixs数组中
 *  ⚠️不可将NS前缀的字符串(包括@"NS")加入classStringPrefixs数组中
 */
+ (void)setupNoneSelClassStringPrefixsArr:(NSArray<NSString *> *)classStringPrefixs;

@end
