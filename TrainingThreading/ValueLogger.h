//
//  NumberLoggerSync.h
//  TrainingThreading
//
//  Created by Fabian Celdeiro on 11/4/14.
//  Copyright (c) 2014 MercadoLibre. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValueLogger : NSObject

@property (nonatomic, copy) void (^completitionBlock)(BOOL finished);


-(void) addValue:(NSString* ) value;
-(void) printValuesWithCompletitionBlock:(void (^)(NSUInteger valuesCount))completionBlock;

@end
