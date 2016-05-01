//
//  NSObject+JJCUK.m
//  JJComponentUpdateKit
//
//  Created by JJ on 11/1/15.
//  Copyright © 2015 JJ. All rights reserved.
//

#import "NSObject+JJCUK.h"

#import <objc/runtime.h>

#import "JJComponentUpdateKitManager.h"

NSString *JJCUKMapTableComponentsIdentityKey = @"JJCUKMapTableComponentsIdentityKey";

@implementation NSObject (JJCUK)

#pragma mark - public

- (void)jjCUK_setUserInfoWithObject:(id)object_ forKey:(id)key_
{
    NSParameterAssert(object_ && key_);
    
    if (!object_ || !key_)
    {
        return;
    }
    
    self.jjCUKUserInfo[key_] = object_;
}

#pragma mark - JJCUKComponentDataSource

- (JJCUKFunctionType *)jjCUK_getFunctionType
{
    return self.jjCUKFunctionType;
}

#pragma mark - getter and setter

- (JJCUKFunctionType *)jjCUKFunctionType
{
    return objc_getAssociatedObject(self, @selector(jjCUKFunctionType));
}

- (void)setJjCUKFunctionType:(NSString *)jjCUKFunctionType_
{
    if (![self.jjCUKFunctionType isEqualToString:jjCUKFunctionType_])
    {
        [[JJComponentUpdateKitManager sharedInstance] removeComponent:self];
        objc_setAssociatedObject(self, @selector(jjCUKFunctionType), jjCUKFunctionType_, OBJC_ASSOCIATION_COPY);
    }
    
    [[JJComponentUpdateKitManager sharedInstance] addComponent:self];
}

- (id<JJCUKComponentDelegate>)jjCUKComponentDelegate
{
    return objc_getAssociatedObject(self, @selector(jjCUKComponentDelegate));
}

- (void)setJjCUKComponentDelegate:(id<JJCUKComponentDelegate>)jjCUKComponentDelegate_
{
    objc_setAssociatedObject(self, @selector(jjCUKComponentDelegate), jjCUKComponentDelegate_, OBJC_ASSOCIATION_ASSIGN);
}

- (NSMutableDictionary *)jjCUKUserInfo
{
    NSMutableDictionary *userInfo = objc_getAssociatedObject(self, @selector(jjCUKUserInfo));
    if (!userInfo)
    {
        userInfo = [NSMutableDictionary dictionary];
        self.jjCUKUserInfo = userInfo;
    }
    
    return userInfo;
}

- (void)setJjCUKUserInfo:(NSMutableDictionary *)jjCUKUserInfo_
{
    objc_setAssociatedObject(self, @selector(jjCUKUserInfo), jjCUKUserInfo_, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
