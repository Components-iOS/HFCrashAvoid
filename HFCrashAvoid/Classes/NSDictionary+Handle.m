//
//  NSDictionary+Handle.m
//  HFCrashGuard
//
//  Created by 刘洪飞 on 2021/6/5.
//

#import "NSDictionary+Handle.h"
#import "HandleCrashTools.h"
#import "HandleCrashMacros.h"

@implementation NSDictionary (Handle) 

// 崩溃防护处理
+ (void)handleCrashExchangeMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [HandleCrashTools exchangeClassMethod:self method1Sel:@selector(dictionaryWithObjects:forKeys:count:) method2Sel:@selector(avoidCrashDictionaryWithObjects:forKeys:count:)];
    });
}

+ (instancetype)avoidCrashDictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt {
    id instance = nil;
    
    @try {
        instance = [self avoidCrashDictionaryWithObjects:objects forKeys:keys count:cnt];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultRemoveKeyValue;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
        
        // 处理错误的数据，然后重新初始化一个字典
        NSUInteger index = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        id  _Nonnull __unsafe_unretained newkeys[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] && keys[i]) {
                newObjects[index] = objects[i];
                newkeys[index] = keys[i];
                index++;
            }
        }
        
        instance = [self avoidCrashDictionaryWithObjects:newObjects forKeys:newkeys count:index];
    } @finally {
        return instance;
    }
}

@end
