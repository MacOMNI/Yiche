//
//  CNHttpOperationQueue.m
//  homeWork
//
//  Created by wang xinkai on 15/2/6.
//  Copyright (c) 2015年 wxhl. All rights reserved.
//

#import "CNHttpOperationQueue.h"

#import "CNHttpOperation.h"
CNHttpOperationQueue *instance;
@implementation CNHttpOperationQueue


-(id)init{
    
    if (self = [super init]) {
        
        _globleQueue = [[NSOperationQueue alloc] init];
        
        _globleQueue.maxConcurrentOperationCount = 2;
        
        
        cnOperations = [[NSMutableArray alloc] init];
    }
    return self;
}


+(instancetype)shareCNQueue{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        
        instance= [[CNHttpOperationQueue alloc] init];
        
    });
    
    
    return instance;
    
}


-(void)addOperation:(CNHttpOperation *)cnOp{
    


    
    
    [cnOperations addObject:cnOp];

    
    [cnOp.operation setQueuePriority:NSOperationQueuePriorityNormal];
    
    [self.globleQueue addOperation:cnOp.operation];
    
}
-(void)addOperationStartImmediately:(CNHttpOperation *)cnOp{

    
    [cnOperations addObject:cnOp];
    
    
    [cnOp.operation setQueuePriority:NSOperationQueuePriorityVeryHigh];
    
    [self.globleQueue addOperation:cnOp.operation];

    
}




@end
