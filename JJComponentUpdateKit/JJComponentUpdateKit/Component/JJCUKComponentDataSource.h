//
//  JJCUKComponentDataSource.h
//  JJComponentUpdateKit
//
//  Created by JJ on 11/1/15.
//  Copyright © 2015 JJ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString JJCUKFunctionType;

@protocol JJCUKComponentDataSource <NSObject>

- (JJCUKFunctionType *)jjCUK_getFunctionType;

@end
