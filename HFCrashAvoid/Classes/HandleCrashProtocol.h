//
//  HandleCrashProtocol.h
//  HFCrashGuard
//
//  Created by 刘洪飞 on 2021/6/5.
//

#import <UIKit/UIKit.h>

@protocol HandleCrashProtocol <NSObject>

@required
+ (void)handleCrashExchangeMethod;

@end
