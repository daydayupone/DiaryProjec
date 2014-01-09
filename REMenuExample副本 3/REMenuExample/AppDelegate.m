//
//  AppDelegate.m
//  REMenuExample
//
//  Created by Roman Efimov on 2/20/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "NavigationViewController.h"
#import "HomeViewController.h"
#define UmengAppkey @"52ac1e8556240b08a00c42bc"
#import "UMSocial.h"
#import "FirstViewController.h"

@implementation AppDelegate

#pragma mark -- 初始化社交平台
- (void)initializePlat
{
    //打开调试log的开关
    [UMSocialData openLog:YES];
    
    //如果你要支持不同的屏幕方向，需要这样设置，否则在iPhone只支持一个竖屏方向
    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];
    
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:UmengAppkey];
    
    //设置微信AppId
    [UMSocialConfig setWXAppId:@"wxd9a39c7122aa6516" url:nil];
    ;
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
    //分享图文样式到微信朋友圈显示字数比较少，只显示分享标题
    [UMSocialData defaultData].extConfig.title = @"朋友圈分享内容";
    
    //打开新浪微博的SSO开关
    [UMSocialConfig setSupportSinaSSO:YES];
    
    //设置手机QQ的AppId，url传自己的网址，若传nil将使用友盟的网址
    [UMSocialConfig setQQAppId:@"100424468" url:[NSURL URLWithString:@"http://app.gitom.com/mobileapp/list/12"] importClasses:@[[QQApiInterface class],[TencentOAuth class]]];
    
    //使用友盟统计
    //[MobClick startWithAppkey:UmengAppkey];
    
    [UMSocialConfig setSupportTencentSSO:YES importClass:[WBApi class]];
    
    
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"document path == %@",kDocumentPath);
    
    

    [[UIApplication sharedApplication]setStatusBarStyle:1];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[NavigationViewController alloc] initWithRootViewController:[[FirstViewController alloc] init]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
