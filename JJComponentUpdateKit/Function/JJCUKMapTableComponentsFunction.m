//
//  JJCUKMapTableComponentsFunction.m
//  JJComponentUpdateKit
//
//  Created by JJ on 11/1/15.
//  Copyright © 2015 JJ. All rights reserved.
//

#import "JJCUKMapTableComponentsFunction.h"

#import "NSObject+JJCUK.h"

@implementation JJCUKMapTableComponentsFunction

#pragma mark - public

- (NSMutableArray *)getComponentMArrayByComponent:(NSObject<JJCUKComponentDataSource> *)component_
{
    NSString *identityKey = component_.jjCUKUserInfo[JJCUKMapTableComponentsIdentityKey];
    if (!identityKey)
    {
        return nil;
    }

    NSMutableArray *componentMArray = [self.componentMapTable objectForKey:identityKey];
    return componentMArray;
}

- (NSMutableArray *)getComponentMArrayByObject:(id)object
{
    return nil;
}

- (BOOL)addComponent:(NSObject<JJCUKComponentDataSource> *)component_
{
    NSString *identityKey = component_.jjCUKUserInfo[JJCUKMapTableComponentsIdentityKey];
    if (!identityKey)
    {
        return NO;
    }
    
    NSMutableArray *componentMArray = [self.componentMapTable objectForKey:identityKey];
    
    if (!componentMArray)
    {
        componentMArray = [NSMutableArray array];
        [self.componentMapTable setObject:componentMArray forKey:identityKey];
    }
    
    if (![componentMArray containsObject:component_])
    {
        [componentMArray addObject:component_];
    }
    
    [self updateComponent:component_ withObject:nil];
    
    return NO;
}

- (void)removeComponent:(NSObject<JJCUKComponentDataSource> *)component_
{
    NSString *identityKey = component_.jjCUKUserInfo[JJCUKMapTableComponentsIdentityKey];
    if (!identityKey)
    {
        return;
    }
    
    NSMutableArray *componentMArray = [self.componentMapTable objectForKey:identityKey];
    if (!componentMArray)
    {
        return;
    }
    
    [componentMArray removeObject:component_];
    
    if (0 == [componentMArray count])
    {
        [self.componentMapTable removeObjectForKey:identityKey];
    }
}

- (void)updateAllComponentWithObject:(id)object_
{
    NSMutableArray *componentMArray = [self getComponentMArrayByObject:object_];
    
    for (id<JJCUKComponentDataSource> component in componentMArray)
    {
        [self updateProcessWithComponent:component withObject:object_];
    }
}

@end
