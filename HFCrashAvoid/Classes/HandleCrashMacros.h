//
//  HandleCrashMacros.h
//  HFCrashGuard
//
//  Created by 刘洪飞 on 2021/6/5.
//

#ifndef HandleCrashMacros_h
#define HandleCrashMacros_h

// Release 环境不打印
#ifdef DEBUG
#define  AvoidCrashLog(...) NSLog(@"%@",[NSString stringWithFormat:__VA_ARGS__])
#else
#define AvoidCrashLog(...)
#endif

// 当前设备版本号
#define AvoidCrashIsiOS(version) ([[UIDevice currentDevice].systemVersion floatValue] >= version)

// 错误收集之后发送的通知，外部可以在收到通知后做错误上报的处理
#define HandleCrashNotification     @"HandleCrashNotification"

// AvoidCrash default is to remove nil object and instance a array
#define AvoidCrashDefaultRemoveNil  @"删除了nil对象"
// AvoidCrash default is to return nil to avoid crash
#define AvoidCrashDefaultReturnNil  @"返回了一个nil对象"
// AvoidCrash default is to ignore this operation to avoid crash
#define AvoidCrashDefaultIgnore     @"忽略本次操作"
// AvoidCrash default is to remove nil key-values and instance a dictionary
#define AvoidCrashDefaultRemoveKeyValue    @"删除了key或者value为nil的键值对"
// AvoidCrash default is to return a without assign unichar
#define AvoidCrashDefaultReturnStrNil  @"返回了一个空字符"

// 崩溃日志开始
#define AvoidCrashSeparatorWithFlag @"==== AvoidCrash Log Start ===="
// 崩溃日志结束
#define AvoidCrashSeparator         @"==== AvoidCrash Log End ===="

// 日志发出字典的Key
#define key_errorName               @"errorName"
#define key_errorReason             @"errorReason"
#define key_errorPlace              @"errorPlace"
#define key_defaultToDo             @"defaultToDo"
#define key_callStackSymbols        @"callStackSymbols"
#define key_exception               @"exception"


#endif /* HandleCrashMacros_h */
