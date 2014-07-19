//
//  EMExpenseListViewController.h
//  ExpenseManager
//
//  Created by Ullas Joseph on 14/07/14.
//  Copyright (c) 2014 ullasjoseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMExpenseListViewController : UIViewController
{
    NSDateFormatter *dateFormatter;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) NSPredicate *predicate;

- (IBAction)btnCancelClicked:(id)sender;
@end
