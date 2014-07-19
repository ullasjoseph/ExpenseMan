//
//  EMUtils.h
//  ExpenseManager
//
//  Created by Ullas Joseph on 09/07/14.
//  Copyright (c) 2014 ullasjoseph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMUtils : NSObject

+ (void)showTextInputWithTitle:(NSString *)title
                      delegate:(id)delegate
                           tag:(NSInteger)tag
                  keyboardType:(UIKeyboardType)type;
+ (void)showAlert:(NSString *)msg delegate:(id)delegate;
@end
