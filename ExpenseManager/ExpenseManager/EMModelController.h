//
//  EMModelController.h
//  ExpenseManager
//
//  Created by Ullas Joseph on 08/07/14.
//  Copyright (c) 2014 ullasjoseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EMDataViewController;

@interface EMModelController : NSObject <UIPageViewControllerDataSource>

- (EMDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(EMDataViewController *)viewController;

@end
