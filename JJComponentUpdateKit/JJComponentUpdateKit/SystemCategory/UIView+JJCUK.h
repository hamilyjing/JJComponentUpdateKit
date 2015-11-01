//
//  UIView+JJCUK.h
//  JJComponentUpdateKit
//
//  Created by JJ on 11/1/15.
//  Copyright © 2015 JJ. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *JJCUKComponentUpdateWhenDisappearKey;

@interface UIView (JJCUK)

#pragma mark - visible

- (BOOL)jjCUK_isVisible;

#pragma mark - view controller

- (UIViewController *)jjCUK_viewController;

@end
