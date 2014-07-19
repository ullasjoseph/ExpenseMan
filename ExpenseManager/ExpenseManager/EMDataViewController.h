//
//  EMDataViewController.h
//  ExpenseManager
//
//  Created by Ullas Joseph on 08/07/14.
//  Copyright (c) 2014 ullasjoseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMDataViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblTotalExpense;
@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id dataObject;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (strong, nonatomic) NSNumber *totalExpense;
@property (strong, nonatomic) NSDate *startDate;

@end
