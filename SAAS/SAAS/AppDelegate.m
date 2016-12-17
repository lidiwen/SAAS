//
//  AppDelegate.m
//  SAAS
//
//  Created by Zy on 16/9/6.
//  Copyright © 2016年 ldw. All rights reserved.
//

#import "AppDelegate.h"
#import "SAASDefineHeadFile.h"
#import "SAASCocoapodsHeadFile.h"
@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UMSocialData setAppKey:UMAppKey];
    
    
   [WXApi registerApp:@"wxb4ba3c02aa476ea1" withDescription:@"demo"];
    
    
    [UMSocialWechatHandler setWXAppId:WeChatAppId appSecret:WeChatAppSecret url:@"http://www.mallparking.cn"];

    
    [UMSocialAlipayShareHandler setAlipayShareAppId:@"2016090901876589"];
    
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"2061299789"
                                              secret:@"2a766af36414379c631f0006bf91dfc4"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    [UMSocialQQHandler setQQWithAppId:QQAppID appKey:QQAppKey url:@"http://www.mallparking.cn"];

   
    
    return YES;
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
   if (result == FALSE) {
       return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    return result;
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
