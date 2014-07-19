//
//  EMExpense.h
//  ExpenseManager
//
//  Created by Ullas Joseph on 08/07/14.
//  Copyright (c) 2014 ullasjoseph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMExpense : NSObject

@property(nonatomic) NSNumber *amount;
@property(nonatomic,strong) NSDate *time;
@property(nonatomic,strong) NSString *category;
@property(nonatomic,strong) NSString *payee;
@property(nonatomic,strong) NSString *note;

@end
