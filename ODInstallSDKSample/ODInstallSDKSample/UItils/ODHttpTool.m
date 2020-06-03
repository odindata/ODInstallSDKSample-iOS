//
//  ODHttpTool.m
//  ODInstallSDKSample
//
//  Created by nathan on 2020/5/25.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODHttpTool.h"
#import "ODInstallHeader.h"

//定义一个变量
static ODHttpTool *helper = nil;

@implementation ODHttpTool


//实例化对象
+ (instancetype)shareHelper
{
    @synchronized(self) {
        if (!helper) {
            helper = [[ODHttpTool alloc] init];
        }
        return helper;
    }
}

//get请求
+ (void)getWithUrlString:(NSString *)url parameters:(id)parameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    [self shareHelper];
    //设置请求参数
    NSMutableDictionary *baseParams = [self baseParams];
    [baseParams addEntriesFromDictionary:parameters];
    NSString *hostUrl = [ODIHost  stringByAppendingString:url];
    NSMutableString *reustlUrl = [[NSMutableString alloc]initWithString:hostUrl];
    NSMutableString *mutableUrl = [[NSMutableString alloc] initWithString:reustlUrl];
    if ([parameters allKeys]) {
        [mutableUrl appendString:@"?"];
        for (id key in baseParams) {
            NSString *value = [[baseParams objectForKey:key] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            [mutableUrl appendString:[NSString stringWithFormat:@"%@=%@&", key, value]];
        }
    }
    NSString *urlEnCode = [[mutableUrl substringToIndex:mutableUrl.length - 1] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlEnCode]];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:helper delegateQueue:queue];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failureBlock(error);
        } else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *code = dic[@"code"];
            if (code.integerValue == 0) {
                successBlock(dic[@"data"]);
            }else{
                error = [NSError errorWithDomain:dic[@"msg"] code:code.integerValue userInfo:nil];
                failureBlock(error);
            }
        }
    }];
    [dataTask resume];
}

//post请求
+ (void)postWithUrlString:(NSString *)url parameters:(id)parameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    [self shareHelper];
    
    NSString *hostUrl = [ODIHost  stringByAppendingString:url];
    NSMutableString *reustlUrl = [[NSMutableString alloc]initWithString:hostUrl];
    
    //设置请求参数
    NSMutableDictionary *baseParams = [self baseParams];
    NSURL *nsurl = [NSURL URLWithString:reustlUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:nsurl];
    //设置请求方式
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //设置请求体
    NSString *postStr = @"";
    [baseParams addEntriesFromDictionary:parameters];
    if (parameters) {
        postStr = [ODHttpTool convertToJsonData:baseParams];
        request.HTTPBody = [postStr dataUsingEncoding:NSUTF8StringEncoding];
    }
   
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:helper delegateQueue:queue];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failureBlock(error);
        } else if ([response isKindOfClass:[NSHTTPURLResponse class]]){
           NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode != 200) {
                NSError *resultError = [NSError errorWithDomain:@"" code:httpResponse.statusCode userInfo:nil];
                failureBlock(resultError);
            }else{
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSString *code = dic[@"code"];
                if (code.integerValue == 0) {
                    successBlock(dic[@"data"]);
                }else{
                    error = [NSError errorWithDomain:dic[@"msg"] code:code.integerValue userInfo:nil];
                    failureBlock(error);
                }
            }
        }
        else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *code = dic[@"code"];
            if (code.integerValue == 0) {
                 successBlock(dic[@"data"]);
            }else{
                error = [NSError errorWithDomain:dic[@"msg"] code:code.integerValue userInfo:nil];
                failureBlock(error);
            }
        }
    }];
    [dataTask resume];
}


+ (NSString *)loadOdinKey{
    __block NSString * odinKey = nil;
    __block NSString * odinSecret = nil;
    if (!odinKey || !odinSecret)
    {
        //其次读取Info.plist中的配置
        NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary;
        [infoDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([key isKindOfClass:[NSString class]]
                && [[key lowercaseString] isEqualToString:@"odinkey"]
                && [obj isKindOfClass:[NSString class]])
            {
                odinKey = [obj copy];
            }
            else if ([key isKindOfClass:[NSString class]]
                     && [[key lowercaseString] isEqualToString:@"odinsecret"]
                     && [obj isKindOfClass:[NSString class]])
            {
                odinSecret = [obj copy];
            }
        }];
    }
    if (!odinKey){
        NSLog(@"odinKey 为nil");
    }
    return odinKey;
}

+ (NSMutableDictionary *)baseParams{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"odinKey"] = [[self class] loadOdinKey];
    return params;
}

+ (NSString *)convertToJsonData:(NSDictionary *)dict{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

#pragma mark - NSURLSessionDelegate 代理方法

//主要就是处理HTTPS请求的
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    NSURLProtectionSpace *protectionSpace = challenge.protectionSpace;
    if ([protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        SecTrustRef serverTrust = protectionSpace.serverTrust;
        completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:serverTrust]);
    } else {
        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
    }
}


@end
