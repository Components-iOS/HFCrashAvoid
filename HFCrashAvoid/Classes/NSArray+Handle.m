//
//  NSArray+Handle.m
//  HFCrashGuard
//
//  Created by 刘洪飞 on 2021/6/5.
//

#import "NSArray+Handle.h"
#import "HandleCrashTools.h"
#import "HandleCrashMacros.h"

@implementation NSArray (Handle)

// 崩溃防护处理
+ (void)handleCrashExchangeMethod {
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        // 类方法
        [HandleCrashTools exchangeClassMethod:[self class] method1Sel:@selector(arrayWithObjects:count:) method2Sel:@selector(AvoidCrashArrayWithObjects:count:)];
        
        // 实例方法
        Class __NSArray = NSClassFromString(@"NSArray");
        Class __NSArrayI = NSClassFromString(@"__NSArrayI");
        Class __NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");
        Class __NSArray0 = NSClassFromString(@"__NSArray0");
        
        // objectsAtIndexes:
        [HandleCrashTools exchangeInstanceMethod:__NSArray method1Sel:@selector(objectsAtIndexes:) method2Sel:@selector(avoidCrashObjectsAtIndexes:)];
        
        // objectAtIndex:
        [HandleCrashTools exchangeInstanceMethod:__NSArrayI method1Sel:@selector(objectAtIndex:) method2Sel:@selector(__NSArrayIAvoidCrashObjectAtIndex:)];
        
        [HandleCrashTools exchangeInstanceMethod:__NSSingleObjectArrayI method1Sel:@selector(objectAtIndex:) method2Sel:@selector(__NSSingleObjectArrayIAvoidCrashObjectAtIndex:)];
        
        [HandleCrashTools exchangeInstanceMethod:__NSArray0 method1Sel:@selector(objectAtIndex:) method2Sel:@selector(__NSArray0AvoidCrashObjectAtIndex:)];
        
        // objectAtIndexedSubscript:
        if (AvoidCrashIsiOS(11.0)) {
            [HandleCrashTools exchangeInstanceMethod:__NSArrayI method1Sel:@selector(objectAtIndexedSubscript:) method2Sel:@selector(__NSArrayIAvoidCrashObjectAtIndexedSubscript:)];
        }
        
        // getObjects:range:
        [HandleCrashTools exchangeInstanceMethod:__NSArray method1Sel:@selector(getObjects:range:) method2Sel:@selector(NSArrayAvoidCrashGetObjects:range:)];
        
        [HandleCrashTools exchangeInstanceMethod:__NSSingleObjectArrayI method1Sel:@selector(getObjects:range:) method2Sel:@selector(__NSSingleObjectArrayIAvoidCrashGetObjects:range:)];
        
        [HandleCrashTools exchangeInstanceMethod:__NSArrayI method1Sel:@selector(getObjects:range:) method2Sel:@selector(__NSArrayIAvoidCrashGetObjects:range:)];
    });
}

#pragma mark - instance array

+ (instancetype)AvoidCrashArrayWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
    id instance = nil;
    
    @try {
        instance = [self AvoidCrashArrayWithObjects:objects count:cnt];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultRemoveNil;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
        
        // 以下是对错误数据的处理，把为nil的数据去掉,然后初始化数组
        NSInteger newObjsIndex = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] != nil) {
                newObjects[newObjsIndex] = objects[i];
                newObjsIndex++;
            }
        }
        
        instance = [self AvoidCrashArrayWithObjects:newObjects count:newObjsIndex];
    } @finally {
        return instance;
    }
}

#pragma mark - objectAtIndexedSubscript:

- (id)__NSArrayIAvoidCrashObjectAtIndexedSubscript:(NSUInteger)idx {
    id object = nil;
    
    @try {
        object = [self __NSArrayIAvoidCrashObjectAtIndexedSubscript:idx];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
    } @finally {
        return object;
    }
}

#pragma mark - objectsAtIndexes:

- (NSArray *)avoidCrashObjectsAtIndexes:(NSIndexSet *)indexes {
    NSArray *returnArray = nil;
    
    @try {
        returnArray = [self avoidCrashObjectsAtIndexes:indexes];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
    } @finally {
        return returnArray;
    }
}

#pragma mark - objectAtIndex:

//__NSArrayI  objectAtIndex:
- (id)__NSArrayIAvoidCrashObjectAtIndex:(NSUInteger)index {
    id object = nil;

    @try {
        object = [self __NSArrayIAvoidCrashObjectAtIndex:index];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
    } @finally {
        return object;
    }
}

//__NSSingleObjectArrayI objectAtIndex:
- (id)__NSSingleObjectArrayIAvoidCrashObjectAtIndex:(NSUInteger)index {
    id object = nil;

    @try {
        object = [self __NSSingleObjectArrayIAvoidCrashObjectAtIndex:index];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
    } @finally {
        return object;
    }
}

//__NSArray0 objectAtIndex:
- (id)__NSArray0AvoidCrashObjectAtIndex:(NSUInteger)index {
    id object = nil;

    @try {
        object = [self __NSArray0AvoidCrashObjectAtIndex:index];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
    } @finally {
        return object;
    }
}

#pragma mark - getObjects:range:

//NSArray getObjects:range:
- (void)NSArrayAvoidCrashGetObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    @try {
        [self NSArrayAvoidCrashGetObjects:objects range:range];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
    } @finally {
        
    }
}

//__NSSingleObjectArrayI  getObjects:range:
- (void)__NSSingleObjectArrayIAvoidCrashGetObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    @try {
        [self __NSSingleObjectArrayIAvoidCrashGetObjects:objects range:range];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
    } @finally {
        
    }
}

//__NSArrayI  getObjects:range:
- (void)__NSArrayIAvoidCrashGetObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    @try {
        [self __NSArrayIAvoidCrashGetObjects:objects range:range];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [HandleCrashTools noteErrorWithException:exception defaultToDo:defaultToDo];
    } @finally {
        
    }
}

@end
