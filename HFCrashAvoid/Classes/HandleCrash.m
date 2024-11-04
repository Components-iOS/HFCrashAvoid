//
//  HandleCrash.m
//  HFCrashGuard
//
//  Created by 刘洪飞 on 2021/6/4.
//

#import "HandleCrash.h"

@implementation HandleCrash

+ (void)becomeEffective {
    [self effectiveIfDealWithNoneSel:NO];
}

+ (void)makeAllEffective {
    [self effectiveIfDealWithNoneSel:YES];
}

+ (void)effectiveIfDealWithNoneSel:(BOOL)dealWithNoneSel {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject avoidCrashExchangeMethodIfDealWithNoneSel:dealWithNoneSel];
        
        [NSArray handleCrashExchangeMethod];
        [NSMutableArray handleCrashExchangeMethod];
        
        [NSDictionary handleCrashExchangeMethod];
        [NSMutableDictionary handleCrashExchangeMethod];
        
        [NSString handleCrashExchangeMethod];
        [NSMutableString handleCrashExchangeMethod];
        
        [NSAttributedString handleCrashExchangeMethod];
        [NSMutableAttributedString handleCrashExchangeMethod];
    });
}

+ (void)setupNoneSelClassStringsArr:(NSArray<NSString *> *)classStrings {
    [NSObject setupNoneSelClassStringsArr:classStrings];
}

+ (void)setupNoneSelClassStringPrefixsArr:(NSArray<NSString *> *)classStringPrefixs {
    [NSObject setupNoneSelClassStringPrefixsArr:classStringPrefixs];
}

@end
