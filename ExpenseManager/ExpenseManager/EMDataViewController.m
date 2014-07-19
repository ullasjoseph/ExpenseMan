//
//  EMDataViewController.m
//  ExpenseManager
//
//  Created by Ullas Joseph on 08/07/14.
//  Copyright (c) 2014 ullasjoseph. All rights reserved.
//

#import "EMDataViewController.h"
#import "EMNewExpenseViewController.h"
#import "EMExpenseListViewController.h"
#import "EMCoredataManager.h"
#import "EMPieChartViewController.h"

@interface EMDataViewController ()

@end

@implementation EMDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self loadTotalExpense];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject description];
}



 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     NSPredicate *predicate;
     if ([[segue destinationViewController] isKindOfClass:[EMExpenseListViewController class]]) {
         NSCalendar *cal = [NSCalendar currentCalendar];
         NSDate *now = [NSDate date];
         NSDate *startDay;
         NSTimeInterval interval;
         if ([[self.dataObject description] isEqualToString:@"Expense of the Day"]) {

             [cal rangeOfUnit:NSDayCalendarUnit
                    startDate:&startDay
                     interval:&interval
                      forDate:now];
             
             predicate = [NSPredicate predicateWithFormat:@"date >= %@ ", startDay];
         } else if ([[self.dataObject description] isEqualToString:@"Expense of the Week"]) {
             [cal rangeOfUnit:NSWeekCalendarUnit
                    startDate:&startDay
                     interval:&interval
                      forDate:now];
             
             predicate = [NSPredicate predicateWithFormat:@"date >= %@ ", startDay];
         } else if ([[self.dataObject description] isEqualToString:@"Expense of the Month"]) {
             [cal rangeOfUnit:NSMonthCalendarUnit
                    startDate:&startDay
                     interval:&interval
                      forDate:now];
             
             predicate = [NSPredicate predicateWithFormat:@"date >= %@ ", startDay];
         }
         ((EMExpenseListViewController *)[segue destinationViewController]).predicate = predicate;
     } else if ([[segue destinationViewController] isKindOfClass:[EMPieChartViewController class]]) {
         ((EMPieChartViewController *)[segue destinationViewController]).totalExpense = _totalExpense;
         ((EMPieChartViewController *)[segue destinationViewController]).startDate = _startDate;
     }

 }


- (void)loadTotalExpense {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDate *startDay;
    NSTimeInterval interval;
    NSPredicate *predicate;

    if ([[self.dataObject description] isEqualToString:@"Expense of the Day"]) {
        
        [cal rangeOfUnit:NSDayCalendarUnit
               startDate:&startDay
                interval:&interval
                 forDate:now];
        
        predicate = [NSPredicate predicateWithFormat:@"date >= %@ ", startDay];
    } else if ([[self.dataObject description] isEqualToString:@"Expense of the Week"]) {
        [cal rangeOfUnit:NSWeekCalendarUnit
               startDate:&startDay
                interval:&interval
                 forDate:now];
        
        predicate = [NSPredicate predicateWithFormat:@"date >= %@ ", startDay];
    } else if ([[self.dataObject description] isEqualToString:@"Expense of the Month"]) {
        [cal rangeOfUnit:NSMonthCalendarUnit
               startDate:&startDay
                interval:&interval
                 forDate:now];
        
        predicate = [NSPredicate predicateWithFormat:@"date >= %@ ", startDay];
    }
    _startDate = startDay;
    _totalExpense = [EMCoredataManager getSumOfExpense:predicate];
    _lblTotalExpense.text = [NSString stringWithFormat:@"%.2f$",[_totalExpense doubleValue]];
}

@end
