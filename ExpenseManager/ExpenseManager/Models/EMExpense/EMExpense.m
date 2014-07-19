//
//  EMExpense.m
//  ExpenseManager
//
//  Created by Ullas Joseph on 08/07/14.
//  Copyright (c) 2014 ullasjoseph. All rights reserved.
//

#import "EMExpense.h"

@implementation EMExpense
- (instancetype)init
{
    self = [super init];
    if (self) {
        _time = [NSDate date];
    }
    return self;
}
@end
