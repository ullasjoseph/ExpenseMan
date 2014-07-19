//
//  EMPieChartViewController.h
//  ExpenseManager
//
//  Created by Ullas Joseph on 09/07/14.
//  Copyright (c) 2014 ullasjoseph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieChartView.h"

@interface EMPieChartViewController : UIViewController <PieChartDelegate>
{
    NSMutableArray *categories;
}
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) NSNumber *totalExpense;
@property (strong, nonatomic) NSDate *startDate;

- (IBAction)btnBackClicked:(id)sender;

@end
