//
//  HTTPSessionManager.h
//  SAAS
//
//  Created by Zy on 16/9/7.
//  Copyright © 2016年 ldw. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^ResultBlock)(id responseObj, NSError *error);
typedef void(^GetResultBlock)(id responseObj, NSError *error);
@interface HTTPSessionManager : NSObject

///单例
+ (HTTPSessionManager *)sharedManager;

//GET
- (void)GET:(NSString *)url parameters:(id)parameters result:(GetResultBlock)result;

///POST 请求
-(void)requestHaveSignWithDic:(NSMutableDictionary*)dic adnURL:(NSString*)url andCallBack:(ResultBlock)callback;


@end
