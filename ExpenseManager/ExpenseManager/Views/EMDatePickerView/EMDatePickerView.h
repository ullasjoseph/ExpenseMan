//
//  EMDatePickerView.h
//  ExpenseManager
//
//  Created by Ullas Joseph on 09/07/14.
//  Copyright (c) 2014 ullasjoseph. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DateSelectedBlock)(NSDate *selectedDate);

@interface EMDatePickerView : UIView

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property(readwrite, copy) DateSelectedBlock dateSelectedBlock;

- (IBAction)btnCancelClicked:(id)sender;
- (IBAction)btnDoneClicked:(id)sender;

- (void)showViewInSuperview:(UIView *)superView;

@end
