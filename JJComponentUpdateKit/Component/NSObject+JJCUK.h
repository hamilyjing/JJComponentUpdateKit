//
//  NSObject+JJCUK.h
//  JJComponentUpdateKit
//
//  Created by JJ on 11/1/15.
//  Copyright © 2015 JJ. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JJCUKComponentDataSource.h"
#import "JJCUKComponentDelegate.h"

extern NSString *JJCUKMapTableComponentsIdentityKey;

@interface NSObject (JJCUK) <JJCUKComponentDataSource>

@property (nonatomic, copy) JJCUKFunctionType *jjCUKFunctionType;
@property (nonatomic, weak) id<JJCUKComponentDelegate> jjCUKComponentDelegate;
@property (nonatomic, strong, readonly) NSMutableDictionary *jjCUKUserInfo;

- (void)jjCUK_setUserInfoWithObject:(id)object forKey:(id)key;

@end
