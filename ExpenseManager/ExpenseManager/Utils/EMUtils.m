//
//  EMUtils.m
//  ExpenseManager
//
//  Created by Ullas Joseph on 09/07/14.
//  Copyright (c) 2014 ullasjoseph. All rights reserved.
//

#import "EMUtils.h"

@implementation EMUtils

+ (void)showTextInputWithTitle:(NSString *)title delegate:(id)delegate tag:(NSInteger)tag keyboardType:(UIKeyboardType)type {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:delegate cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert setTag:tag];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField *textField = [alert textFieldAtIndex:0];
    [textField setKeyboardType:type];
    
    [alert show];
}

+ (void)showAlert:(NSString *)msg delegate:(id)delegate {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:msg delegate:delegate cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

@end
