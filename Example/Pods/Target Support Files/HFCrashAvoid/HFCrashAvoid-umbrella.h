#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "HandleCrash.h"
#import "HandleCrashMacros.h"
#import "HandleCrashProtocol.h"
#import "HandleCrashStubProxy.h"
#import "HandleCrashTools.h"
#import "NSArray+Handle.h"
#import "NSAttributedString+Handle.h"
#import "NSDictionary+Handle.h"
#import "NSMutableArray+Handle.h"
#import "NSMutableAttributedString+Handle.h"
#import "NSMutableDictionary+Handle.h"
#import "NSMutableString+Handle.h"
#import "NSObject+Handle.h"
#import "NSString+Handle.h"

FOUNDATION_EXPORT double HFCrashAvoidVersionNumber;
FOUNDATION_EXPORT const unsigned char HFCrashAvoidVersionString[];

