//
//  UIView+JJCUK.m
//  JJComponentUpdateKit
//
//  Created by JJ on 11/1/15.
//  Copyright © 2015 JJ. All rights reserved.
//

#import "UIView+JJCUK.h"

NSString *JJCUKComponentUpdateWhenDisappearKey = @"JJCUKComponentUpdateWhenDisappearKey";

@implementation UIView (JJCUK)

#pragma mark - visible

- (BOOL)jjCUK_isVisible
{
    UIViewController *vc = [self jjCUK_viewController];
    if (!vc)
    {
        return NO;
    }
    
    BOOL isVCLoad = [vc isViewLoaded];
    BOOL haveWindow = (vc.view.window != nil);
    
    return (isVCLoad && haveWindow);
}

#pragma mark - view controller

- (UIViewController *)jjCUK_viewController
{
    for (UIView *next = [self superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
