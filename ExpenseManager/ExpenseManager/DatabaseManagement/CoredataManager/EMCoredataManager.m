//
//  EMCoredataManager.m
//  ExpenseManager
//
//  Created by Ullas Joseph on 11/07/14.
//  Copyright (c) 2014 ullasjoseph. All rights reserved.
//

#import "EMCoredataManager.h"
#import "EMAppDelegate.h"

@interface EMCoredataManager()

@end

@implementation EMCoredataManager

static NSManagedObjectContext *context;

+ (NSManagedObject *)getCoredataObject {
    
    NSManagedObject *newExpense = [NSEntityDescription insertNewObjectForEntityForName:@"Expense"
                                                                inManagedObjectContext:self.context];
    return newExpense;
}

+ (NSManagedObjectContext *)context {
    if (!context) {
        EMAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        context = [appDelegate managedObjectContext];
    }
    return context;
}

+ (void)saveData:(NSManagedObject *)newExpense {
    NSError *error;
    [self.context save:&error];
}

+ (NSArray *)getAllExpenses:(NSPredicate *)predicate {
    
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"Expense"
                inManagedObjectContext:self.context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    if (predicate) {
        [request setPredicate:predicate];
    }
    
    NSError *error;
    NSArray *objects = [self.context executeFetchRequest:request
                                              error:&error];
    
    if ([objects count] == 0) {
        [EMUtils showAlert:@"No data" delegate:nil];
    } else {
        return objects;
    }
    return NULL;
}

+ (NSNumber *)getSumOfExpense:(NSPredicate *)predicate {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Expense"];
    fetchRequest.resultType = NSDictionaryResultType;
    NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
    expressionDescription.name = @"sumOfExpense";
    expressionDescription.expression = [NSExpression expressionForKeyPath:@"@sum.amount"];
    expressionDescription.expressionResultType = NSDecimalAttributeType;
    
    fetchRequest.propertiesToFetch = @[expressionDescription];
    if (predicate) {
        [fetchRequest setPredicate:predicate];
    }
    NSError *error = nil;
    NSArray *result = [self.context executeFetchRequest:fetchRequest error:&error];
    if (result == nil)
    {
        NSLog(@"Error: %@", error);
    }
    else
    {
        return [[result objectAtIndex:0] objectForKey:@"sumOfExpense"];
    }
    return nil;
}

@end
