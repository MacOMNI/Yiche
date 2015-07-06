//
//  CNHttpRequest.m
//  homeWork
//
//  Created by wang xinkai on 15/2/5.
//  Copyright (c) 2015年 wxhl. All rights reserved.
//

#import "CNHttpRequest.h"
#import "CNHttpOperation.h"
#import "CNHttpOperationQueue.h"

@implementation CNHttpRequest

-(void)dealloc{

}

+(void)httpRequestWithURL:(NSString*)url
                   params:(NSDictionary*)params
               httpMethod:(NSString*)method
             succeedBlock:(void(^)(id responseObj)) sucBlock
                failBlock:(void(^)(NSHTTPURLResponse*response))failBlock{
    
    
    //构造URL
    NSURL *_url = [NSURL URLWithString:url];
    
    //    构造request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:_url];
    
    [request setTimeoutInterval:60];
    [request setHTTPMethod:method];
    
    
    //    正常形式  （如果接口要求是JSon格式的，需要换一种拼接方式 ）
    //    name=123&password=123123
    NSString*paramsString = [CNHttpRequest paramsStringFrom:params];
    
    if ([method isEqualToString:@"GET"]) {
        
        NSString*separe = _url.query?@"&":@"?";
        NSString*fullURL = [[NSString stringWithFormat:@"%@%@%@",url,separe,paramsString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:fullURL];
        
        [request setURL:url];
    }else{
        
        [request setHTTPBody:[paramsString dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    NSLog(@"%@",request.URL);
    //    queue
    
    
    
    CNHttpOperation*op1 =  [[CNHttpOperation alloc] initWithRequest:request];
    
    [op1 setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
//        Debug_Log(@"%.2f",(float)totalBytesWritten/totalBytesExpectedToWrite);
        
    }];
    
    [op1 setFailBlock:^(NSHTTPURLResponse *response) {
        
        
        
    }];
    
    
    
    [op1 setSucceedBlock:^(NSData* responseObj) {
        
        //        sucBlock([NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableContainers error:nil]);        
        
        sucBlock([NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableContainers error:nil]);
        
    }];
    
    
    
    
    //    开启
    
    [[CNHttpOperationQueue shareCNQueue] addOperation:op1];
    
    

    
    
    
    
    
    
}


-(void)initWithHttpRequestWithURL:(NSString*)url
                          params:(NSDictionary*)params
                      httpMethod:(NSString*)method
                    succeedBlock:(void(^)(id responseObj)) sucBlock
                       failBlock:(void(^)(NSHTTPURLResponse*response))failBlock{

    
    
}



//上传文件件


+(void)httpUploadFileWithURL:(NSString*)url
                   params:(NSDictionary*)params
                fieldName:(NSString*)fieldName
                 fileName:(NSString*)fileName
          fileContentType:(NSString*)fileContentType
                     data:(NSData*)fileData
             succeedBlock:(void(^)(id responseObj)) sucBlock
                failBlock:(void(^)(NSHTTPURLResponse*response))failBlock
         UploadProgressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))uploadBlock{

    //构造URL
    NSURL *_url = [NSURL URLWithString:url];
    
    //    构造request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:_url];
    
    [request setTimeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    
    
    
//    分隔符
    NSString*boundary = @"AaB03x";
    
    
    
    
//    生成Body

    NSData *httpBody = [self httpFormDataBodyWithBoundary:boundary params:params fieldName:fieldName fileName:fileName fileContentType:fileContentType data:fileData];
    
//    
//    [request setHTTPBody:httpBody];
//    
//    
////    设置请求头
//    NSString*contentTypeValue  = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
//    
//    [request addValue:contentTypeValue forHTTPHeaderField:@"Content-Type"];
//    [request addValue:[NSString stringWithFormat:@"%ld", httpBody.length] forHTTPHeaderField:@"Content-Length"];
//
//    
//    NSLog(@"%@",[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]);
//    
    
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",boundary];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%ld", [httpBody length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:httpBody];
    //http method
    [request setHTTPMethod:@"POST"];

    
    CNHttpOperation*op1 =  [[CNHttpOperation alloc] initWithRequest:request];
    
    [op1 setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
        NSLog(@"%.2f",(float)totalBytesWritten/totalBytesExpectedToWrite);
        
    }];
    
    //    开启
    
    [[CNHttpOperationQueue shareCNQueue] addOperation:op1];
    
    

    
}



+(void)makeOperation:(NSURLRequest*)request{
    //    queue
    


}

//生成请求体方法 （Form-Data）
//sample
/*
 
 Content-type: multipart/form-data, boundary=AaB03x
 
 form-data
 
 --AaB03x
 content-disposition: form-data; name="field1"
 
 Joe Blow
 --AaB03x
 content-disposition: form-data; name="pics"; filename="file1.txt"
 Content-Type: text/plain
 
 ... contents of file1.txt ...
 --AaB03x--
 content-disposition: form-data; name="pics"; filename="file2.txt"
 Content-Type: text/plain
 
 ... contents of file2.txt ...
 --AaB03x--
 */


+(NSData*)httpFormDataBodyWithBoundary:(NSString*)boundary
                params:(NSDictionary*)params
                   fieldName:(NSString*)fieldName
                    fileName:(NSString*)fileName
             fileContentType:(NSString*)fileContentType
                        data:(NSData*)fileData{

    NSString*preBoundary = [NSString stringWithFormat:@"--%@",boundary];
    
    NSString*endBoundary = [NSString stringWithFormat:@"--%@--",boundary];

    
    NSMutableString *body = [[NSMutableString alloc] init];
    
    //遍历keys
    for(NSString*key in params)
    {
        //得到当前key

        //如果key不是pic，说明value是字符类型，比如name：Boris
            //添加分界线，换行 必须使用  \r\n
            [body appendFormat:@"%@\r\n",preBoundary];
            //添加字段名称，换2行
            [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
            //添加字段的值
            [body appendFormat:@"%@\r\n",[params objectForKey:key]];
        
    }
    
    ////添加分界线，换行
    [body appendFormat:@"%@\r\n",preBoundary];
    //声明pic字段，文件名为boris.png
    [body appendFormat:@"Content-Disposition: form-data; name=\"pic\"; filename=\"pic.png\"\r\n"];
    //声明上传文件的格式
    [body appendFormat:@"Content-Type: image/png\r\n\r\n"];
    
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endBoundary];
    //声明myRequestData，用来放入http body
    
    
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    //将image的data加入
    [myRequestData appendData:fileData];
    //加入结束符--AaB03x--
//    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
#pragma mark test
    
    NSMutableString *b = [[NSMutableString alloc] init];
    [b appendFormat:@"\r\n%@\r\n",preBoundary];
    //声明pic字段，文件名为boris.png
    [b appendFormat:@"Content-Disposition: form-data; name=\"pic\"; filename=\"pic1.png\"\r\n"];
    //声明上传文件的格式
    [b appendFormat:@"Content-Type: image/png\r\n\r\n"];

    
    NSData *data = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"2" ofType:@"png"]];

    
    [myRequestData appendData:[b dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequestData appendData:data];
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
#pragma mark test end
    /*
    
    
    NSMutableData *retData = [[NSMutableData alloc] init];
    
    
    NSString*preBoundary = [NSString stringWithFormat:@"--%@",boundary];

    NSString*endBoundary = [NSString stringWithFormat:@"--%@--",boundary];
    
    NSMutableString *bodyStr  = [[NSMutableString alloc] initWithFormat:@""];
    
    
//    --AaB03x
//    content-disposition: form-data; name="field1"
//    
//    Joe Blow

    for (NSString*key in params) {
        
        [bodyStr appendString:preBoundary];
        
        [bodyStr appendFormat:@"\r\nContent-Disposition: form-data; name=\"%@\" \r\n\r\n",key];
        
        [bodyStr appendFormat:@"%@\r\n",params[key]];
    }
    
    
    
    
//    --AaB03x
//    content-disposition: form-data; name="pics"; filename="file1.txt"
//    Content-Type: text/plain
//
    
    [bodyStr appendFormat:@"%@\r\n",preBoundary];
    
    [bodyStr appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",fieldName,fileName];
    [bodyStr appendFormat:@"Content-Type: %@\r\n\r\n",fileContentType];
    
    NSData*data1 = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    
//    --AaB03x--

    NSData *data2 = [[NSString stringWithFormat:@"\r\n%@", endBoundary] dataUsingEncoding:NSUTF8StringEncoding];
    
    
    [retData appendData:data1];
    [retData appendData:fileData];
    [retData appendData:data2];
    
//    NSLog(@"%@",[[NSString alloc] initWithData:retData encoding:NSUTF8StringEncoding]);
    
    
//    --wxkwxk001
//    Content-Disposition: form-data; name="status"
//    
//    jjj
//    --wxkwxk001
//    Content-Disposition: form-data; name="access_token"
//    
//    2.00TSa6WDewTgPDfa63e0f0883oK2XE
//    --wxkwxk001
//    Content-Disposition: form-data; name="pic"; filename="pic.png"
//    Content-Type: image/png
//    
    
//    --AaB03x
//    Content-Disposition: form-data; name="status"
//    
//    asdfasdf
//    --AaB03x
//    Content-Disposition: form-data; name="access_token"
//    
//    2.00TSa6WDewTgPDfa63e0f0883oK2XE
//    --AaB03x
//    Content-Disposition: form-data; name="pic"; filename="pic.png"
//    Content-Type: image/png
//
*/
    
    
    return myRequestData;
}



+(NSString*)paramsStringFrom:(NSDictionary*)dic{
    NSMutableString *ret = [[NSMutableString alloc] init];
    
    for (NSString*key in dic) {
        
        [ret appendFormat:@"%@=%@",key,dic[key]];
        
        
        if (key!=[[dic allKeys] lastObject]) {
            
            [ret appendString:@"&"];
        }
        
    }
    
    return ret;
}

@end
