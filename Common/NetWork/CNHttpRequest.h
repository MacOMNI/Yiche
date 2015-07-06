//
//  CNHttpRequest.h
//  homeWork
//
//  Created by wang xinkai on 15/2/5.
//  Copyright (c) 2015年 wxhl. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef  void(^SucBlock)(id responseObj) ;

@interface CNHttpRequest : NSObject
{
    
    SucBlock _succeedBlocks;
    
}
+(void)httpRequestWithURL:(NSString*)url
                   params:(NSDictionary*)params
               httpMethod:(NSString*)method
                  succeedBlock:(void(^)(id responseObj)) sucBlock
                failBlock:(void(^)(NSHTTPURLResponse*response))failBlock;

+(void)httpUploadFileWithURL:(NSString*)url
                      params:(NSDictionary*)params
                   fieldName:(NSString*)fieldName
                    fileName:(NSString*)fileName
             fileContentType:(NSString*)fileContentType
                        data:(NSData*)fileData
                succeedBlock:(void(^)(id responseObj)) sucBlock
                   failBlock:(void(^)(NSHTTPURLResponse*response))failBlock
UploadProgressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))block;;



@end
