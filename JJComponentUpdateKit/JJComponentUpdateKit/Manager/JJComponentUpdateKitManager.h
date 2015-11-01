//
//  JJComponentUpdateKitManager.h
//  JJObjCTool
//
//  Created by gongjian03 on 8/7/15.
//  Copyright © 2015 gongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JJCUKComponentDataSource.h"

@interface JJComponentUpdateKitManager : NSObject

+ (instancetype)sharedInstance;

- (BOOL)addComponent:(id<JJCUKComponentDataSource>)component;
- (void)removeComponent:(id<JJCUKComponentDataSource>)component;

+ (void)setFunctionTypeDictionary:(NSDictionary *)dic;

@end
