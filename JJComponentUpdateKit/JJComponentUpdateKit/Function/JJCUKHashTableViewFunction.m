//
//  JJCUKHashTableViewFunction.m
//  JJObjCTool
//
//  Created by hamilyjing on 8/7/15.
//  Copyright © 2015 gongjian. All rights reserved.
//

#import "JJCUKHashTableViewFunction.h"

#import "NSObject+JJCUK.h"
#import "UIView+JJCUK.h"

@implementation JJCUKHashTableViewFunction

#pragma mark - public

- (void)updateProcessWithComponent:(NSObject<JJCUKComponentDataSource> *)component_ withObject:(id)object_
{
    BOOL shouldUpdateWhenDisappear = NO;
    NSNumber *updateWhenDisappear = component_.jjCUKUserInfo[JJCUKComponentUpdateWhenDisappearKey];
    if (updateWhenDisappear)
    {
        shouldUpdateWhenDisappear = [updateWhenDisappear boolValue];
    }
    if (shouldUpdateWhenDisappear)
    {
        BOOL viewHidden = ![(UIView *)component_ jjCUK_isVisible];
        if (viewHidden)
        {
            return;
        }
    }
    
    [super updateProcessWithComponent:component_ withObject:object_];
}

@end
