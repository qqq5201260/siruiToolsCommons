//
//  FZKPayManager.h
//  siruiDemo1
//
//  Created by czl on 2017/3/24.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WXApi.h"

typedef NS_ENUM(NSInteger,PayType){

    PayTypeALI,//支付宝支付
    PayTypeWINXIN//微信支付
};

@interface FZKPayManager : NSObject




/**
 注册微信支付和支付宝 appkey

 @param WXAppkey 微信appkey
 @param aliAppkey 支付宝appkey 目前阿里appkey 不需要再本地写入，服务器自动返回 因此可以设置为nil
 */
+(void)registerWXAppkey:(NSString *)WXAppkey aliAppkey:(NSString *)aliAppkey;

/**
 支付数据以及

 @param params 支付参数
 @param type 支付方式
 */
+(void)payWithParams:(id)params type:(PayType) type;


/**
 调用支付结果

 @param url 支付结果字符串
 @param delegate 这里必填主appdelegate，不过是微信支付的时候才会发挥作用
 @return 支付宝  直接返回支付结果，微信支付返回接收信息失败或者成功并设置主APPDelegate 为代理
 */
+(BOOL)getPayResult:(NSURL *)url appDelegate:(id<WXApiDelegate>)delegate;



/**
 微信支付结果处理

 @param resp 获取微信返回信息
 */
+(void)WXPay:(BaseResp *)resp;
@end
