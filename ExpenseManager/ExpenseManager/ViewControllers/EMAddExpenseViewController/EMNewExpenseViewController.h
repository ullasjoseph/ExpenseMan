//
//  EMNewExpenseViewController.h
//  ExpenseManager
//
//  Created by Ullas Joseph on 08/07/14.
//  Copyright (c) 2014 ullasjoseph. All rights reserved.
//

#import "EMDataViewController.h"
#import "EMExpense.h"

@interface EMNewExpenseViewController : EMDataViewController <UIAlertViewDelegate>
{
    NSDateFormatter *dateFormatter;
}
@property (weak, nonatomic) IBOutlet UILabel *lblCategory;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblPayee;
@property (weak, nonatomic) IBOutlet UITextView *txtViewDescription;

@property (strong, nonatomic) EMExpense *expense;

- (IBAction)containerViewTouched:(id)sender;
- (IBAction)btnAmountClicked:(id)sender;
- (IBAction)btnDateClicked:(id)sender;
- (IBAction)btnResetClicked:(id)sender;
- (IBAction)btnSaveClicked:(id)sender;

@end
