//
//  OperationManager.m
//  TrainingThreading
//
//  Created by Fabian Celdeiro on 11/5/14.
//  Copyright (c) 2014 MercadoLibre. All rights reserved.
//

#import "OperationManager.h"

@interface OperationManager()
@property (nonatomic,strong) ValueLogger * valueLogger;
@end

@implementation OperationManager

-(id) init{
    if (self = [super init]){
        self.valueLogger = [[ValueLogger alloc] init];
    }
    
    return self;
        
}


-(void) startOperationsWithCompletitionBlock:(void (^)(BOOL finished))completionBlock{
  
    int valuesToAdd = 10;
    
    for (int i = 1 ;i<=valuesToAdd ; i++){
        [self.valueLogger addValue:[NSString stringWithFormat:@"%i",i]];

    }

    
    [self.valueLogger printValuesWithCompletitionBlock:^(NSUInteger valuesCount) {
        if (valuesCount == valuesToAdd){
            completionBlock(YES);
        }
        else{
            completionBlock(NO);
        }
    }];

    
    
    

    
    
        
    
    

 }



@end
