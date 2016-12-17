//
//  HTTPSessionManager.m
//  SAAS
//
//  Created by Zy on 16/9/7.
//  Copyright © 2016年 ldw. All rights reserved.
//
#import "SAASCocoapodsHeadFile.h"
#import "HTTPSessionManager.h"
@implementation HTTPSessionManager
+ (HTTPSessionManager *)sharedManager
{
    static HTTPSessionManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HTTPSessionManager alloc] init];
    });
    return instance;
}
-(void)requestHaveSignWithDic:(NSMutableDictionary*)dic adnURL:(NSString *)url andCallBack:(ResultBlock)callback{
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//规定返回data
    
   [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
       NSLog(@"");
   } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       callback(responseObject,nil);
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       NSLog(@"error");
   }];
}
- (void)GET:(NSString *)url parameters:(id)parameters result:(GetResultBlock)result
{
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//规定返回data

    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
         NSLog(@"");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
