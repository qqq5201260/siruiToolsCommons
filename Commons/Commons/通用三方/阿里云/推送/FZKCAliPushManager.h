//
//  FZKCAliPushManager.h
//  Commons
//
//  Created by czl on 2017/3/24.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CloudPushSDK/CloudPushSDK.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface FZKCAliPushManager : NSObject


/**
 注册阿里推送相关信息

 @param appkey appkey description
 @param appSecret appSecret description
 @param callback callback description
 @param object 设置代理
 @param launchOptions 点击通知将App从关闭状态启动时，将通知打开回执上报
 */
+(void)registerAliPushAppKey:(NSString *)appkey appSecret:(NSString *)appSecret callback:(CallbackHandler)callback appDelegateAndMessageReceive:(id<UNUserNotificationCenterDelegate>)object sendNotificationAck:(NSDictionary *)launchOptions;

/**
 注册阿里云推送

 @param appkey appkey
 @param appSecret appSecret
 @param callback 注册回调
 */
//+ (void)registerAliPushAppKey:(NSString *)appkey appSecret:(NSString *)appSecret callback:(CallbackHandler)callback;

/**
 注册 apns responder 必须添加代理<UNUserNotificationCenterDelegate> 并实现代理
 
 @param responder iOS10 以后设置代理
 */
//+ (void)registerAPNsDelegate:(id<UNUserNotificationCenterDelegate>)responder;


/**
 苹果apns设备注册

 @param res 设备注册回调
 */
+ (void)registerDevice:deviceToken withCallback:(CallbackHandler)res;


/**
 *    注册推送消息到来监听
 */
//+ (void)registerMessageReceive:(id)observer;

/**
 *    处理到来推送消息
 *
 *    @param     notification
 */
//+ (void)onMessageReceived:(NSNotification *)notification;


/**
 // 点击通知将App从关闭状态启动时，将通知打开回执上报
 // [CloudPushSDK handleLaunching:launchOptions];(Deprecated from v1.8.1)

 @param launchOptions
 */
//+ (void)sendNotificationAck:(NSDictionary *)launchOptions;

/*
 *  App处于启动状态时，通知打开回调
 */
+ (void)applicationDidReceiveRemoteNotification:(NSDictionary*)userInfo;


/**
 打开推送通知时进行的处理

 @param response UNNotificationResponse
 */
+ (void)didReceiveNotificationResponse:(UNNotificationResponse *)response;
@end
