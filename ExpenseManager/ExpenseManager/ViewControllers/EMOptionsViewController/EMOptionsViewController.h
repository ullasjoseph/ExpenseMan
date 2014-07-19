//
//  EMOptionsViewController.h
//  ExpenseManager
//
//  Created by Ullas Joseph on 09/07/14.
//  Copyright (c) 2014 ullasjoseph. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^OptionsAddBlock)(NSString *newItem);
typedef void (^OptionsSelectBlock)(NSString *selectedItem);
typedef void (^OptionsDeleteBlock)(NSString *deletedItem);

@interface EMOptionsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *list;

@property(readwrite, copy) OptionsAddBlock newOptionAddBlock;
@property(readwrite, copy) OptionsSelectBlock optionSelectBlock;
@property(readwrite, copy) OptionsDeleteBlock optionDeleteBlock;

- (IBAction)btnCancelClicked:(id)sender;
- (IBAction)btnAddClicked:(id)sender;

@end
