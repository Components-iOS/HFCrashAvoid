//
//  NSObject+Handle.h
//  HFCrashGuard
//
//  Created by 刘洪飞 on 2021/6/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Handle)

/**
 *  Can avoid crash method
 *
 *  1.- (void)setValue:(id)value forKey:(NSString *)key
 *  2.- (void)setValue:(id)value forKeyPath:(NSString *)keyPath
 *  3.- (void)setValue:(id)value forUndefinedKey:(NSString *)key //这个方法一般用来重写，不会主动调用
 *  4.- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues
 *  5. unrecognized selector sent to instance
 *
 */

/**
 *  ifDealWithNoneSel : 是否开启"unrecognized selector sent to instance"异常的捕获
 */
+ (void)avoidCrashExchangeMethodIfDealWithNoneSel:(BOOL)ifDealWithNoneSel;

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

NS_ASSUME_NONNULL_END
