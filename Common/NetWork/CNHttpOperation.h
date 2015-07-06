//
//  CNHttpOperation.h
//  homeWork
//
//  Created by wang xinkai on 15/2/6.
//  Copyright (c) 2015年 wxhl. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DataBlock) (NSUInteger , long long , long long);
typedef void(^FailBlock)(NSHTTPURLResponse*response);
typedef void(^SucceedBlock)(NSData* response);
@interface CNHttpOperation : NSObject<NSURLConnectionDataDelegate>
{
 
//    上传block
    DataBlock _uploadBlock;
    
    FailBlock _failBlock;
    SucceedBlock _succeedBlock;
    
    NSMutableData *_data;
    
}




//NSURLConnection  in this operation
@property (nonatomic,strong) NSOperation *operation;


@property (nonatomic,strong) NSURLRequest *request;


@property (nonatomic,strong) NSURLConnection *connection;


-(id)initWithRequest:(NSURLRequest*)request;


- (void)setUploadProgressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))block;



-(void)setFailBlock:(void(^)(NSHTTPURLResponse*response))failBlock;
-(void)setSucceedBlock:(void(^)(NSData* responseObj)) sucBlock;


@end
