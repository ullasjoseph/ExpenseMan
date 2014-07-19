//
//  EMCoredataManager.h
//  ExpenseManager
//
//  Created by Ullas Joseph on 11/07/14.
//  Copyright (c) 2014 ullasjoseph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface EMCoredataManager : NSObject

+ (NSManagedObject *)getCoredataObject;
+ (void)saveData:(NSManagedObject *)newExpense;
+ (NSArray *)getAllExpenses:(NSPredicate *)predicate;
+ (NSNumber *)getSumOfExpense:(NSPredicate *)predicate;
@end