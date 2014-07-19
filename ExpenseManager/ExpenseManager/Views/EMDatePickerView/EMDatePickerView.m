//
//  EMDatePickerView.m
//  ExpenseManager
//
//  Created by Ullas Joseph on 09/07/14.
//  Copyright (c) 2014 ullasjoseph. All rights reserved.
//

#import "EMDatePickerView.h"

@implementation EMDatePickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"EMDatePickerView" owner:self options:nil] objectAtIndex:0];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    [[[self viewWithTag:1] layer] setCornerRadius:10];
    [[[self viewWithTag:2] layer] setCornerRadius:10];
}


#pragma mark - IBActions

- (IBAction)btnCancelClicked:(id)sender {
    [self removeViewFromSuperview];
}

- (IBAction)btnDoneClicked:(id)sender {
    if (_dateSelectedBlock)
        _dateSelectedBlock([_datePicker date]);
    [self removeViewFromSuperview];

}


#pragma mark - Utils 

- (void)showViewInSuperview:(UIView *)superView {
    [superView addSubview:self];
    [UIView animateWithDuration: 0.3
                     animations:^{
                         self.alpha = 0.0;
                         self.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                     }];
}

- (void)removeViewFromSuperview {
    [UIView animateWithDuration: 0.3
                     animations:^{
                         self.alpha = 1.0;
                         self.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

@end
