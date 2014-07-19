//
//  EMNewExpenseViewController.m
//  ExpenseManager
//
//  Created by Ullas Joseph on 08/07/14.
//  Copyright (c) 2014 ullasjoseph. All rights reserved.
//

#import "EMNewExpenseViewController.h"
#import "EMDatePickerView.h"
#import "EMOptionsViewController.h"
#import "EMPListManager.h"
#import "EMCoredataManager.h"

@interface EMNewExpenseViewController ()

@property(nonatomic, strong)EMCoredataManager *coredataManager;

@end

@implementation EMNewExpenseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    if(!_expense)
        _expense = [EMExpense new];
    _coredataManager = [[EMCoredataManager alloc] init];
    [self loadExpenceInView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    EMOptionsViewController *optionsViewController = [segue destinationViewController];

    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"categorySelectionSegue"]) {
        NSMutableArray *categories = [EMPListManager getPlistArray:@"ExpenseCategories"];
        optionsViewController.list = categories;
        [optionsViewController setOptionSelectBlock:^(NSString *selectedItem){
            _expense.category = selectedItem;
            [self loadExpenceInView];
        }];
        [optionsViewController setNewOptionAddBlock:^(NSString *newItem){
            [EMPListManager setPlistArray:@"ExpenseCategories" strValue:newItem];
        }];
        [optionsViewController setOptionDeleteBlock:^(NSString *newItem){
            [EMPListManager removePlistArray:@"ExpenseCategories" strValue:newItem];
        }];
    }
    if ([segue.identifier isEqualToString:@"payeeSelectionSegue"]) {
        NSMutableArray *payees = [EMPListManager getPlistArray:@"ExpensePayees"];
        optionsViewController.list = payees;
        [optionsViewController setOptionSelectBlock:^(NSString *selectedItem){
            _expense.payee = selectedItem;
            [self loadExpenceInView];
        }];
        [optionsViewController setNewOptionAddBlock:^(NSString *newItem){
            [EMPListManager setPlistArray:@"ExpensePayees" strValue:newItem];
        }];
        [optionsViewController setOptionDeleteBlock:^(NSString *newItem){
            [EMPListManager removePlistArray:@"ExpensePayees" strValue:newItem];
        }];
        
    }

}


#pragma mark - Alert Delegates

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        _expense.amount = [NSNumber numberWithDouble:[textField.text doubleValue]];
        [self loadExpenceInView];
    }
}


#pragma mark - IBActions

- (IBAction)containerViewTouched:(id)sender {
    if([_txtViewDescription isFirstResponder])
       [_txtViewDescription resignFirstResponder];
}

- (IBAction)btnAmountClicked:(id)sender {
    [EMUtils showTextInputWithTitle:@"Enter Amount" delegate:self tag:1 keyboardType:UIKeyboardTypeNumberPad];
}

- (IBAction)btnDateClicked:(id)sender {
    [self showDatePicker];
}

- (IBAction)btnResetClicked:(id)sender {
    _expense = [[EMExpense alloc] init];
    [self loadExpenceInView];
}

- (IBAction)btnSaveClicked:(id)sender {
    
    if ([self validate]) {
        [EMCoredataManager saveData:[self getNewExpence]];
        [EMUtils showAlert:@"Saved" delegate:self];
        _expense = [[EMExpense alloc] init];
        [self loadExpenceInView];
    }
}


#pragma mark - Utils

- (void)loadExpenceInView {
    _lblCategory.text = _expense.category;
    _lblDate.text = [dateFormatter stringFromDate:_expense.time];
    _lblAmount.text = [NSString stringWithFormat:@"%f $",[_expense.amount doubleValue]];
    _lblPayee.text = _expense.payee;
    _txtViewDescription.text = _expense.note;
}

- (BOOL)validate {
    if (_expense.category.length == 0) {
        [EMUtils showAlert:@"Select Category" delegate:self];
        return NO;
    }
    return YES;
}

- (void)showDatePicker {
    EMDatePickerView *datePicker = [[EMDatePickerView alloc] initWithFrame:self.view.bounds];
    [datePicker setDateSelectedBlock:^(NSDate *selectedDate){
        _expense.time = selectedDate;
        [self loadExpenceInView];
    }];
    [datePicker showViewInSuperview:self.view];
}

- (NSManagedObject *)getNewExpence {
    NSManagedObject *data = [EMCoredataManager getCoredataObject];
    
    [data setValue:_expense.category forKey:EXPENSE_CATEGORY];
    [data setValue:_expense.time forKey:EXPENSE_DATE];
    [data setValue:_expense.amount forKey:EXPENSE_AMOUNT];
    [data setValue:_expense.payee forKey:EXPENSE_PAYEE];
    [data setValue:_expense.note forKey:EXPENSE_NOTE];
    return data;
}
@end
