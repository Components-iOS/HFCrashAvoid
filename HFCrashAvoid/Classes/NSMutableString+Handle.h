//
//  NSMutableString+Handle.h
//  HFCrashGuard
//
//  Created by 刘洪飞 on 2021/6/6.
//

#import <Foundation/Foundation.h>
#import "HandleCrashProtocol.h"

@interface NSMutableString (Handle) <HandleCrashProtocol>

/**
 *  Can avoid crash method
 *
 *  1. 由于NSMutableString是继承于NSString,所以这里和NSString有些同样的方法就不重复写了
 *  2. - (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)aString
 *  3. - (void)insertString:(NSString *)aString atIndex:(NSUInteger)loc
 *  4. - (void)deleteCharactersInRange:(NSRange)range
 *
 */

@end
