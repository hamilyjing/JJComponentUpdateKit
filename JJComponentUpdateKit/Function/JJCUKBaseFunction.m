//
//  JJCUKBaseFunction.m
//  JJObjCTool
//
//  Created by gongjian03 on 8/7/15.
//  Copyright © 2015 gongjian. All rights reserved.
//

#import "JJCUKBaseFunction.h"

#import "NSObject+JJCUK.h"

@implementation JJCUKBaseFunction

#pragma mark - life cycle

- (void)dealloc
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

#pragma mark - public

- (BOOL)addComponent:(id<JJCUKComponentDataSource>)component_
{
    return NO;
}

- (void)removeComponent:(id<JJCUKComponentDataSource>)component_
{
    
}

- (void)updateProcessWithComponent:(NSObject<JJCUKComponentDataSource> *)component_ withObject:(id)object_
{
    if (![self shouldUpdateComponent:component_ withObject:object_])
    {
        return;
    }
    
    if ([component_.jjCUKComponentDelegate respondsToSelector:@selector(jjCUK_shouldUpdateComponent:)])
    {
        if (![component_.jjCUKComponentDelegate jjCUK_shouldUpdateComponent:component_])
        {
            return;
        }
    }
    
    if ([component_.jjCUKComponentDelegate respondsToSelector:@selector(jjCUK_willUpdateComponent:)])
    {
        [component_.jjCUKComponentDelegate jjCUK_willUpdateComponent:component_];
    }
    
    [self updateComponent:component_ withObject:object_];
    
    if ([component_.jjCUKComponentDelegate respondsToSelector:@selector(jjCUK_didUpdateComponent:)])
    {
        [component_.jjCUKComponentDelegate jjCUK_didUpdateComponent:component_];
    }
}

- (BOOL)shouldUpdateComponent:(id<JJCUKComponentDataSource>)component_ withObject:(id)object_
{
    return YES;
}

- (void)updateComponent:(id<JJCUKComponentDataSource>)component_ withObject:(id)object_
{
    
}

- (void)updateAllComponentWithObject:(id)object_
{
    
}

#pragma mark - getter and setter

- (NSMapTable *)componentMapTable
{
    if (!_componentMapTable)
    {
        _componentMapTable = [NSMapTable strongToWeakObjectsMapTable];
    }
    
    return _componentMapTable;
}

- (NSHashTable *)componentHashTable
{
    if (!_componentHashTable)
    {
        _componentHashTable = [NSHashTable weakObjectsHashTable];
    }
    
    return _componentHashTable;
}

@end
