//
//  JJComponentUpdateKitManager.m
//  JJObjCTool
//
//  Created by gongjian03 on 8/7/15.
//  Copyright © 2015 gongjian. All rights reserved.
//

#import "JJComponentUpdateKitManager.h"

#import "JJCUKBaseFunction.h"

static JJComponentUpdateKitManager *g_s_instance = nil;

@interface JJComponentUpdateKitManager ()

@property (nonatomic, strong) NSMutableDictionary *functionTypeDic;

@end

@implementation JJComponentUpdateKitManager

#pragma mark - life cycle

#pragma mark - public

+ (JJComponentUpdateKitManager *)sharedInstance
{
    if(nil == g_s_instance)
    {
        static dispatch_once_t oncePredicate;
        dispatch_once(&oncePredicate, ^{
            g_s_instance = [[self alloc] init];
        });
    }
    
    return g_s_instance;
}

- (BOOL)addComponent:(id<JJCUKComponentDataSource>)component_
{
    NSParameterAssert(component_);
    
    if (!component_)
    {
        return NO;
    }
    
    JJCUKBaseFunction *baseFunction = [self getBaseFunction:[component_ jjCUK_getFunctionType]];
    return [baseFunction addComponent:component_];
}

- (void)removeComponent:(id<JJCUKComponentDataSource>)component_
{
    NSParameterAssert(component_);
    
    if (!component_)
    {
        return;
    }
    
    JJCUKBaseFunction *baseFunction = [self getBaseFunction:[component_ jjCUK_getFunctionType]];
    [baseFunction removeComponent:component_];
}

+ (void)setFunctionTypeDictionary:(NSDictionary *)dic_
{
    NSParameterAssert(dic_);
    
    [JJComponentUpdateKitManager sharedInstance].functionTypeDic = [dic_ mutableCopy];
}

#pragma mark - private

- (JJCUKBaseFunction *)getBaseFunction:(NSString *)functionType_
{
    if ([functionType_ length] <= 0)
    {
        return nil;
    }
    
    JJCUKBaseFunction *baseFunction = self.functionTypeDic[functionType_];
    
    if (!baseFunction)
    {
        NSString *functionName = functionType_;
        Class functionClass = NSClassFromString(functionName);
        if (!functionClass)
        {
            NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
            NSString *swiftClassName = [NSString stringWithFormat:@"_TtC%ld%@%ld%@", (long)appName.length, appName, (long)functionName.length, functionName];
            functionClass = NSClassFromString(swiftClassName);
            if (!functionClass)
            {
                NSAssert(NO, @"Class is nil from class string: %@", functionName);
            }
        }
        
        baseFunction = [[functionClass alloc] init];
        if (baseFunction)
        {
            self.functionTypeDic[functionType_] = baseFunction;
        }
    }
    
    return baseFunction;
}

#pragma mark - getter and setter

- (NSMutableDictionary *)functionTypeDic
{
    if (!_functionTypeDic)
    {
        _functionTypeDic = [NSMutableDictionary dictionary];
    }
    
    return _functionTypeDic;
}

@end
