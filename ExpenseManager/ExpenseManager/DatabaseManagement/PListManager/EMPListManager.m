//
//  EMPListManager.m
//  ExpenseManager
//
//  Created by Ullas Joseph on 09/07/14.
//  Copyright (c) 2014 ullasjoseph. All rights reserved.
//

#import "EMPListManager.h"

@implementation EMPListManager

+(NSString *)getDocsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return documentsDirectory;
}

+(BOOL)setPlist:(NSString *)strPlistName {
    NSError *error;
    NSString *path = [[self getDocsDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", strPlistName]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:path]) {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:strPlistName ofType:@"plist"];
        [fileManager copyItemAtPath:bundle toPath:path error:&error];
        return YES;
    }
    else {
        return NO;
    }
}

+(void)setPlistData:(NSString *)strPlistName key:(NSString *)key strValue:(NSString *)strValue {
    [self setPlist:strPlistName];
    
    NSString *path = [[self getDocsDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", strPlistName]];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    [data setObject:strValue forKey:key];
    //[data setObject:[NSNumber numberWithInt:strValue] forKey:key];
    
    [data writeToFile:path atomically:YES];
}

+(id)getPlistData:(NSString *)strPlistName key:(NSString *)key {
    [self setPlist:strPlistName];
    
    NSString *path = [[self getDocsDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", strPlistName]];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    return [data objectForKey:key];
}

+(NSMutableArray *)getPlistArray:(NSString *)strPlistName {
    [self setPlist:strPlistName];
    
    NSString *path = [[self getDocsDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", strPlistName]];
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile: path];
    return data;
}

+(void)setPlistArray:(NSString *)strPlistName strValue:(NSString *)strValue {
    [self setPlist:strPlistName];
    
    NSString *path = [[self getDocsDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", strPlistName]];
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    [data addObject:strValue];
    
    [data writeToFile:path atomically:YES];
}

+(void)removePlistArray:(NSString *)strPlistName strValue:(NSString *)strValue {
    [self setPlist:strPlistName];
    
    NSString *path = [[self getDocsDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", strPlistName]];
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    [data removeObject:strValue];
    
    [data writeToFile:path atomically:YES];
}
@end
