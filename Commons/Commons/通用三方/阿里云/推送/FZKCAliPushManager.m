//
//  FZKCAliPushManager.m
//  Commons
//
//  Created by czl on 2017/3/24.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKCAliPushManager.h"
#import <UIKit/UIKit.h>

@implementation FZKCAliPushManager


+(void)registerAliPushAppKey:(NSString *)appkey appSecret:(NSString *)appSecret callback:(CallbackHandler)callback appDelegateAndMessageReceive:(id<UNUserNotificationCenterDelegate>)object sendNotificationAck:(NSDictionary *)launchOptions{
//    注册阿里云推送
    [CloudPushSDK asyncInit:appkey appSecret:appSecret callback:callback];
//    注册苹果apns推送
    [FZKCAliPushManager registerAPNsDelegate:object];
//    推送消息通知
    [FZKCAliPushManager registerMessageReceive];
//   获取消息进行处理
    [CloudPushSDK sendNotificationAck:launchOptions];
    
}

/**
 注册阿里云推送
 
 @param appkey appkey
 @param appSecret appSecret
 @param callback 注册回调
 */
+(void)registerAliPushAppKey:(NSString *)appkey appSecret:(NSString *)appSecret callback:(CallbackHandler)callback{

    [CloudPushSDK asyncInit:appkey appSecret:appSecret callback:callback];
}


/**
 注册 apns responder 必须添加代理<UNUserNotificationCenterDelegate> 并实现代理
 
 @param responder iOS10 以后设置代理
 */
+(void)registerAPNsDelegate:(id<UNUserNotificationCenterDelegate>)responder{
    
    UIApplication *application = [UIApplication sharedApplication];
    CGFloat vision = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (vision >= 10.0 ) {
        
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!error) {
                NSLog(@"request authorization succeeded!");
            }
        }];
        [UNUserNotificationCenter currentNotificationCenter].delegate = responder;
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
#endif
        
    }
    else if (vision >= 8.0) { //iOS8.0以后注册方法与之前有所不同，需要要分别对待
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes: (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge) categories: nil];
        
        [application registerUserNotificationSettings: settings];
        
        [application registerForRemoteNotifications];
        
    }else{ //iOS8.0以前版本的注册方法
        
        [application registerForRemoteNotificationTypes: (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge)];
    }
    
}


+ (void)registerDevice:deviceToken withCallback:(CallbackHandler)res {
    [CloudPushSDK registerDevice:deviceToken withCallback:res];
}

/**
 *    注册推送消息到来监听
 */
+ (void)registerMessageReceive{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onMessageReceived:)
                                                 name:@"CCPDidReceiveMessageNotification"
                                               object:nil];
}

/**
 *    处理到来推送消息
 *
 *    @param     notification
 */
+ (void)onMessageReceived:(NSNotification *)notification {
    CCPSysMessage *message = [notification object];
    NSString *title = [[NSString alloc] initWithData:message.title encoding:NSUTF8StringEncoding];
    NSString *body = [[NSString alloc] initWithData:message.body encoding:NSUTF8StringEncoding];
    NSLog(@"Receive message title: %@, content: %@.", title, body);
}

/**
 // 点击通知将App从关闭状态启动时，将通知打开回执上报
 // [CloudPushSDK handleLaunching:launchOptions];(Deprecated from v1.8.1)
 
 @param launchOptions
 */
+ (void)sendNotificationAck:(NSDictionary *)launchOptions{

    [CloudPushSDK sendNotificationAck:launchOptions];

}

+ (void)applicationDidReceiveRemoteNotification:(NSDictionary*)userInfo {
    NSLog(@"Receive one notification.");

    // 取得APNS通知内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    // 内容
    NSString *content = [aps valueForKey:@"alert"];
    // badge数量
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue];
    // 播放声音
    NSString *sound = [aps valueForKey:@"sound"];
    // 取得Extras字段内容
    NSString *Extras = [userInfo valueForKey:@"Extras"]; //服务端中Extras字段，key是自己定义的
    NSLog(@"content = [%@], badge = [%ld], sound = [%@], Extras = [%@]", content, (long)badge, sound, Extras);
    
    // iOS badge 清0
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    // 通知打开回执上报
    // [CloudPushSDK handleReceiveRemoteNotification:userInfo];(Deprecated from v1.8.1)
    [self sendNotificationAck:userInfo];
}

+(void)didReceiveNotificationResponse:(UNNotificationResponse *)response{

     NSString *userAction = response.actionIdentifier;
    // 点击通知打开
    if ([userAction isEqualToString:UNNotificationDefaultActionIdentifier]) {
        NSLog(@"User opened the notification.");
        // 处理iOS 10通知，并上报通知打开回执
        [self handleiOS10Notification:response.notification];
    }

}

/**
 *  处理iOS 10通知(iOS 10+)
 */
+ (void)handleiOS10Notification:(UNNotification *)notification {
    UNNotificationRequest *request = notification.request;
    UNNotificationContent *content = request.content;
    NSDictionary *userInfo = content.userInfo;
    // 通知时间
    NSDate *noticeDate = notification.date;
    // 标题
    NSString *title = content.title;
    // 副标题
    NSString *subtitle = content.subtitle;
    // 内容
    NSString *body = content.body;
    // 角标
    int badge = [content.badge intValue];
    // 取得通知自定义字段内容，例：获取key为"Extras"的内容
    NSString *extras = [userInfo valueForKey:@"Extras"];
    // 通知打开回执上报
    [CloudPushSDK sendNotificationAck:userInfo];
    NSLog(@"Notification, date: %@, title: %@, subtitle: %@, body: %@, badge: %d, extras: %@.", noticeDate, title, subtitle, body, badge, extras);
}

@end
