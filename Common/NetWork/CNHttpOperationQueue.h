//
//  CNHttpOperationQueue.h
//  homeWork
//
//  Created by wang xinkai on 15/2/6.
//  Copyright (c) 2015年 wxhl. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CNHttpOperation;
@interface CNHttpOperationQueue : NSObject
{
    NSMutableArray *cnOperations;
}
@property (nonatomic,strong) NSOperationQueue *globleQueue;


+(instancetype)shareCNQueue;


-(void)addOperation:(CNHttpOperation *)cnOp;

-(void)addOperationStartImmediately:(CNHttpOperation *)cnOp;


@end
