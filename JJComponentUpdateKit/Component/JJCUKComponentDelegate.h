//
//  JJCUKComponentDelegate.h
//  JJComponentUpdateKit
//
//  Created by JJ on 11/1/15.
//  Copyright © 2015 JJ. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JJCUKComponentDataSource.h"

@protocol JJCUKComponentDelegate <NSObject>

@optional
- (BOOL)jjCUK_shouldUpdateComponent:(id<JJCUKComponentDataSource>)component;
- (void)jjCUK_willUpdateComponent:(id<JJCUKComponentDataSource>)component;
- (void)jjCUK_didUpdateComponent:(id<JJCUKComponentDataSource>)component;

@end
