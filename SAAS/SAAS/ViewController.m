//
//  ViewController.m
//  SAAS
//
//  Created by Zy on 16/9/6.
//  Copyright © 2016年 ldw. All rights reserved.
//
#import "SAASDefineHeadFile.h"
#import "ViewController.h"
#import "SAASCocoapodsHeadFile.h"
@interface ViewController ()<UMSocialUIDelegate>

@end

@implementation ViewController


-(void)viewWillAppear:(BOOL)animated
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"userId" forKey:@"userId"];
    
    [[HTTPSessionManager sharedManager] requestHaveSignWithDic:dict adnURL:@"http:192.168.1.253:3000/pay/account/getmoney" andCallBack:^(id responseObj, NSError *error) {
    
         NSDictionary* myDic = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:NULL];
        NSLog(@"==== %@",myDic);
        
    }];
  
    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskLandscape];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)AliPay:(UIButton *)sender {
    
    
}

- (IBAction)WeChat:(UIButton *)sender {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }
    });
}

- (IBAction)Sina:(UIButton *)sender {
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }});
}
- (IBAction)QQ:(UIButton *)sender {
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }});
}
- (IBAction)WeChatPay:(UIButton *)sender {
    NSString *res = [WXApiRequestHandler jumpToBizPay];
    if( ![@"" isEqual:res] ){
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付失败" message:res delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alter show];
    }

}
- (IBAction)Share:(UIButton *)sender {
    
    XHCustomShareView *shareView = [XHCustomShareView shareViewWithPresentedViewController:self items:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,UMShareToSina,UMShareToAlipaySession] title:@"小猫停车" image:[UIImage imageNamed:@"icon.png"] urlResource:nil];
    [[UIApplication sharedApplication].keyWindow addSubview:shareView];
}
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:UMAppKey
//                                      shareText:@"花花的简书"
//                                     shareImage:[UIImage imageNamed:@"icon.png"]
//                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToQQ,UMShareToQzone,UMShareToSina,UMShareToAlipaySession,nil]
//                                       delegate:self];
//点击每个平台后默认会进入内容编辑页面，若想点击后直接分享内容，可以实现下面的回调方法
//弹出列表方法presentSnsIconSheetView需要设置delegate为self  默认yes
-(BOOL)isDirectShareInIconActionSheet
{
    return YES;
}

//实现回调方法
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}


@end
