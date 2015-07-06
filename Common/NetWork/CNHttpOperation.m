//
//  CNHttpOperation.m
//  homeWork
//
//  Created by wang xinkai on 15/2/6.
//  Copyright (c) 2015年 wxhl. All rights reserved.
//

#import "CNHttpOperation.h"

@implementation CNHttpOperation

-(void)dealloc{

}
-(id)initWithRequest:(NSURLRequest*)request{

    if (self = [super init]) {
        
        
        _request = request;
        
        

        
//        _operation = [NSBlockOperation blockOperationWithBlock:^{
//            
//            
//            //            添加 connection 到operation内
//            
//            
//            
//            
//        }];

        
        
        _operation =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(runConnection) object:nil];
        
        
    }
    
    return  self;
}


-(void)runConnection{

//在非主线程调用解决方案     http://blog.csdn.net/zengconggen/article/details/7718571
    
    dispatch_sync(dispatch_get_main_queue(), ^{
  
        _connection =  [NSURLConnection connectionWithRequest:_request delegate:self];
        
        _data = [[NSMutableData alloc] init];
    });


}

-(void)setFailBlock:(void(^)(NSHTTPURLResponse*response))failBlock{
    
    _failBlock = failBlock;
}
-(void)setSucceedBlock:(void(^)(NSData* responseObj)) sucBlock{

    
    _succeedBlock = sucBlock;
}

- (void)setUploadProgressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))block{
    _uploadBlock = block;
}


#pragma mark URLConnection delegate

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    
//    失败


    
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{

//    失败
    
    
    
    
    if(_failBlock){
        NSHTTPURLResponse*res  = (NSHTTPURLResponse*)response;
        if(res.statusCode != 200){
            _failBlock(res);
        }
    
    }
    
    
    
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{

    
    [_data appendData:data];
    
    
}

//- (NSInputStream *)connection:(NSURLConnection *)connection needNewBodyStream:(NSURLRequest *)request;
- (void)connection:(NSURLConnection *)connection
                        didSendBodyData:(NSInteger)bytesWritten
                         totalBytesWritten:(NSInteger)totalBytesWritten
                        totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite{

//    上传进度
    
    
    
    if (_uploadBlock) {
        _uploadBlock(bytesWritten,totalBytesWritten,totalBytesExpectedToWrite);
    }

    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    
    @try {
        if (_succeedBlock) {
            
            _succeedBlock(_data);
            
        }
        
    }
    @catch (NSException *exception) {
//        Debug_Log(@"%@",exception);
    }
    @finally {
        
    }
    
}

@end
