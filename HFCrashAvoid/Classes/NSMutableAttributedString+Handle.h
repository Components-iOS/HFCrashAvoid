//
//  NSMutableAttributedString+Handle.h
//  HFCrashGuard
//
//  Created by 刘洪飞 on 2021/6/6.
//

#import <Foundation/Foundation.h>
#import "HandleCrashProtocol.h"

@interface NSMutableAttributedString (Handle) <HandleCrashProtocol>

/**
 *  Can avoid crash method
 *
 *  1.- (instancetype)initWithString:(NSString *)str
 *  2.- (instancetype)initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs
 *
 */

@end
