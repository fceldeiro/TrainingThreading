//
//  NumberLoggerSync.m
//  TrainingThreading
//
//  Created by Fabian Celdeiro on 11/4/14.
//  Copyright (c) 2014 MercadoLibre. All rights reserved.
//

#import "ValueLogger.h"
#include <stdlib.h>

@interface ValueLogger()
@property (nonatomic,strong) dispatch_queue_t serialQueue;

@property (atomic,strong) NSMutableArray * storedValues;
@end

@implementation ValueLogger


-(id) init{
 
    if (self = [super init]){
        
        self.storedValues = [NSMutableArray arrayWithCapacity:30];

    }
    return self;
}

-(void) addValue:(NSString*) value
{
    int sleepTime = arc4random_uniform(3)+1;
    
    sleep(sleepTime);

    @synchronized(self){
        [self.storedValues addObject:[value copy]];
        NSLog(@"Value added %@",value);
    }

    

}

-(void) printValuesWithCompletitionBlock:(void (^)(NSUInteger valuesCount))completionBlock{
    
    sleep(1);
    
    @synchronized(self){
        NSLog(@"Stored Values %lu :%@", (unsigned long)self.storedValues.count , self.storedValues);
        completionBlock(self.storedValues.count);
       // [self.storedValues removeAllObjects];
    }
    
    
}

@end
