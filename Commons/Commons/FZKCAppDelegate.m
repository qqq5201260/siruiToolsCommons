//
//  AppDelegate.m
//  Commons
//
//  Created by czl on 2017/3/24.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKCAppDelegate.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "FZKPayManager.h"
#import "FZKCAliPushManager.h"
#import "FZKAppkeyComon.h"

@interface FZKCAppDelegate ()<WXApiDelegate,UNUserNotificationCenterDelegate>

@end

@implementation FZKCAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [FZKPayManager registerWXAppkey:WXPayAppkey aliAppkey:nil];
//    [FZKCAliPushManager registerAliPushAppKey:AliPushAppkey appSecret:@"" callback:^(CloudPushCallbackResult *res) {
//        if (res.success) {
//            NSLog(@"Push SDK init success, deviceId: %@.", [CloudPushSDK getDeviceId]);
//        } else {
//            NSLog(@"Push SDK init failed, error: %@", res.error);
//        }
//        
//    }];
    
//    [FZKCAliPushManager registerAPNsDelegate:self];
//    [FZKCAliPushManager registerMessageReceive:self];
//    [FZKCAliPushManager sendNotificationAck:launchOptions];
//    注册推送
    [FZKCAliPushManager registerAliPushAppKey:AliPushAppkey appSecret:AliPushAppSecret callback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            NSLog(@"Push SDK init success, deviceId: %@.", [CloudPushSDK getDeviceId]);
            NSLog(@"\n推送状态%d\n",[CloudPushSDK isChannelOpened]);
        } else {
            NSLog(@"Push SDK init failed, error: %@", res.error);
        }
        
    } appDelegateAndMessageReceive:self sendNotificationAck:launchOptions];
//    [CloudPushSDK turnOnDebug];
//    NSLog(@"\n推送状态%d\n",[CloudPushSDK isChannelOpened]);
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo{

    [FZKCAliPushManager applicationDidReceiveRemoteNotification:userInfo];

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

// 重写AppDelegate的handleOpenURL和openURL方法
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

//支付结果回调处理
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    return  [self getPayResult:url];;
}

-(BOOL)getPayResult:(NSURL *)url{
    //    if ([url.host isEqualToString:@"safepay"]) {
    //        // 支付跳转支付宝钱包进行支付，处理支付结果
    //        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
    //            NSLog(@"result1 = %@", resultDic);
    //            NSString *stringCode;
    //            NSString * payState;
    //            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
    //                stringCode = @"支付完成";
    //                //                 [GLAFRequest startRequest:CallBack paramsDic:resultDic view:nil com:^(id sta) {
    //                //                     //  NSLog(@"搜索藏品持有人 = %@",sta);
    //                //                     [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    //                //                 }];
    //                payState = @"1";
    //            }else{
    //                payState = @"0";
    //                if ([resultDic[@"resultStatus"] isEqualToString:@"8000"]){
    //                    stringCode = @"正在处理中";
    //                }else if ([resultDic[@"resultStatus"] isEqualToString:@"4000"]){
    //                    stringCode = @"正在处理中";
    //                }else if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]){
    //                    stringCode = @"已取消付款";
    //                }else if ([resultDic[@"resultStatus"] isEqualToString:@"6002"]){
    //                    stringCode = @"网络连接错误";
    //                }
    //            }
    //            [[NSNotificationCenter defaultCenter] postNotificationName:@"payResultCenter" object:@([payState integerValue])];
    //        }];
    //
    //        // 授权跳转支付宝钱包进行支付，处理结果
    ////        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
    ////            NSLog(@"result = %@",resultDic);
    ////            // 解析 auth code
    ////            NSString *result = resultDic[@"result"];
    ////            NSString *authCode = nil;
    ////            if (result.length>0) {
    ////                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
    ////                for (NSString *subResult in resultArr) {
    ////                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
    ////                        authCode = [subResult substringFromIndex:10];
    ////                        break;
    ////                    }
    ////                }
    ////            }
    ////            NSLog(@"授权结果 authCode = %@", authCode?:@"");
    ////        }];
    //        return YES;
    //    }
    //    //    if ([url.host isEqualToString:@"pay"]) {
    //    //
    //    //    printf("%s",url.host);
    //    //        return YES;
    //    //    }
    ////    NSLog(@"host:%@,port:%@",url.host,url.port);
    //
    //    //    return [WXApi handleOpenURL:url delegate:self];
    //    return [WXApi handleOpenURL:url delegate:self];
    return [FZKPayManager getPayResult:url appDelegate:self];
}


-(void) onResp:(BaseResp*)resp
{
    //    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    //    NSString *strTitle;
    //
    //    //    if([resp isKindOfClass:[SendMessageToWXResp class]])
    //    //    {
    //    //        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    //    //    }
    //    NSString *payState;
    //    if([resp isKindOfClass:[PayResp class]]){
    //        //支付返回结果，实际支付结果需要去微信服务器端查询
    //        strTitle = [NSString stringWithFormat:@"支付结果"];
    //
    //        switch (resp.errCode) {
    //            case WXSuccess:
    //                payState = @"1";
    //                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
    //                break;
    //            default:
    //                payState = @"0";
    //                break;
    //        }
    //
    //    }
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"payResultCenter" object:@([payState integerValue])];
    [FZKPayManager WXPay:resp];
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //    [alert show];
}


-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    //    if ([url.host isEqualToString:@"safepay"]) {
    //        // 支付跳转支付宝钱包进行支付，处理支付结果
    //        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
    //            NSLog(@"支付结果 = %@",resultDic);
    //        }];
    //
    //        // 授权跳转支付宝钱包进行支付，处理支付结果
    //        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
    //            NSLog(@"result = %@",resultDic);
    //            // 解析 auth code
    //            NSString *result = resultDic[@"result"];
    //            NSString *authCode = nil;
    //            if (result.length>0) {
    //                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
    //                for (NSString *subResult in resultArr) {
    //                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
    //                        authCode = [subResult substringFromIndex:10];
    //                        break;
    //                    }
    //                }
    //            }
    //            NSLog(@"授权结果 authCode = %@", authCode?:@"");
    //        }];
    //           return YES;
    //    }
    return [FZKPayManager getPayResult:url appDelegate:self];
    
}

#pragma mark - 推送apns 设备注册
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken{
    [CloudPushSDK registerDevice:deviceToken withCallback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            NSLog(@"Register deviceToken success.");
            NSLog(@"\n推送状态%d\n",[CloudPushSDK isChannelOpened]);
        } else {
            NSLog(@"Register deviceToken failed, error: %@", res.error);
        }
    }];

}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError %@", error);
}


#pragma mark - ios10以后推送代理通知回调

/**
 *  App处于前台时收到通知(iOS 10+)
 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSLog(@"Receive a notification in foregound.");
    // 处理iOS 10通知，并上报通知打开回执
//    [self handleiOS10Notification:notification];
    // 通知不弹出
//    completionHandler(UNNotificationPresentationOptionNone);
    
    // 通知弹出，且带有声音、内容和角标
    completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    [FZKCAliPushManager didReceiveNotificationResponse:response];
    completionHandler();
}



@end
