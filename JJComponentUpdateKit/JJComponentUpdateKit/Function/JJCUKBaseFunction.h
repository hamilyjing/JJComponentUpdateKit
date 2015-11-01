//
//  JJCUKBaseFunction.h
//  JJObjCTool
//
//  Created by gongjian03 on 8/7/15.
//  Copyright © 2015 gongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JJCUKComponentDataSource.h"

@interface JJCUKBaseFunction : NSObject

@property (nonatomic, strong) NSMapTable *componentMapTable;
@property (nonatomic, strong) NSHashTable *componentHashTable;

- (BOOL)addComponent:(id<JJCUKComponentDataSource>)component;
- (void)removeComponent:(id<JJCUKComponentDataSource>)component;

- (void)updateProcessWithComponent:(id<JJCUKComponentDataSource>)component withObject:(id)object;

- (BOOL)shouldUpdateComponent:(id<JJCUKComponentDataSource>)component withObject:(id)object;
- (void)updateComponent:(id<JJCUKComponentDataSource>)component withObject:(id)object;

- (void)updateAllComponentWithObject:(id)object;

@end
