//
//  JJCUKHashTableComponentsFunction.m
//  JJComponentUpdateKit
//
//  Created by JJ on 11/1/15.
//  Copyright © 2015 JJ. All rights reserved.
//

#import "JJCUKHashTableComponentsFunction.h"

#import "NSObject+JJCUK.h"

@implementation JJCUKHashTableComponentsFunction

#pragma mark - public

- (BOOL)addComponent:(id<JJCUKComponentDataSource>)component_
{
    if (![self.componentHashTable containsObject:component_])
    {
        [self.componentHashTable addObject:component_];
    }
    
    [self updateComponent:component_ withObject:nil];
    
    return YES;
}

- (void)removeComponent:(id<JJCUKComponentDataSource>)component_
{
    [self.componentHashTable removeObject:component_];
}

- (void)updateAllComponentWithObject:(id)object_
{
    for (NSObject<JJCUKComponentDataSource> *component in self.componentHashTable)
    {
        [self updateProcessWithComponent:component withObject:object_];
    }
}

@end
