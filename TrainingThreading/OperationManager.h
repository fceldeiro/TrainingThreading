//
//  OperationManager.h
//  TrainingThreading
//
//  Created by Fabian Celdeiro on 11/5/14.
//  Copyright (c) 2014 MercadoLibre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ValueLogger.h"

@interface OperationManager : NSObject

-(void) startOperationsWithCompletitionBlock:(void (^)(BOOL finished))completionBlock;
@end
