//
//  EMPListManager.h
//  ExpenseManager
//
//  Created by Ullas Joseph on 09/07/14.
//  Copyright (c) 2014 ullasjoseph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMPListManager : NSObject

+(NSString *)getDocsDirectory;
+(BOOL)setPlist:(NSString *)strPlistName;

+(void)setPlistData:(NSString *)strPlistName key:(NSString *)key strValue:(NSString *)strValue;
+(id)getPlistData:(NSString *)strPlistName key:(NSString *)key;

+(NSMutableArray *)getPlistArray:(NSString *)strPlistName;
+(void)setPlistArray:(NSString *)strPlistName strValue:(NSString *)strValue;
+(void)removePlistArray:(NSString *)strPlistName strValue:(NSString *)strValue;
@end
