



//
//  FZKPayManager.m
//  siruiDemo1
//
//  Created by czl on 2017/3/24.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKPayManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApiRequestHandler.h"
//#import "WXApi.h"
#import "Order.h"


@implementation FZKPayManager



+(void)registerWXAppkey:(NSString *)WXAppkey aliAppkey:(NSString *)aliAppkey{

       [WXApi registerApp:WXAppkey withDescription:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]];

}

+(void)payWithParams:(id)params type:(PayType) type{

    if (type==PayTypeALI) {
        [self aliPay:params];
    }else{
    [WXApiRequestHandler jumpToBizPay:params];
        
    }

}

+ (void)aliPay:(NSString *)orderString{
    
    NSString *appScheme = @"siruiDemo12016122914501212";
    
    //        调用支付结果
    [[AlipaySDK defaultService]payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        [self alipayResult:resultDic];
    }];
    //    }
    
}

+(BOOL)getPayResult:(NSURL *)url appDelegate:(id<WXApiDelegate>)delegate{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
          [self alipayResult:resultDic];
        }];

        return YES;
    }

    return [WXApi handleOpenURL:url delegate:delegate];
    
}

/**
 微信支付结果处理
 
 @param resp 获取微信返回信息
 */
+(void)WXPay:(BaseResp *)resp{
//    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    

    NSInteger payState;
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                payState = 1;
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
            default:
                payState = 0;
                break;
        }
        
    }
    [self sendPayResult:payState];
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //    [alert show];
}


/**
 根据返回结果发出通知

 @param payState 返回结果码 0：失败，1成功
 */
+ (void)sendPayResult:(NSInteger)payState{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"payResultCenter" object:@(payState)];
}


/**
 阿里支付结果处理

 @param resultDic 支付结果参数
 */
+ (void)alipayResult:(NSDictionary *)resultDic{
    NSLog(@"result1 = %@", resultDic);
    NSString *stringCode;
    NSInteger  payState;
    if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
        stringCode = @"支付完成";
        //                 [GLAFRequest startRequest:CallBack paramsDic:resultDic view:nil com:^(id sta) {
        //                     //  NSLog(@"搜索藏品持有人 = %@",sta);
        //                     [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        //                 }];
        payState = 1;
    }else{
        payState = 0;
        if ([resultDic[@"resultStatus"] isEqualToString:@"8000"]){
            stringCode = @"正在处理中";
        }else if ([resultDic[@"resultStatus"] isEqualToString:@"4000"]){
            stringCode = @"正在处理中";
        }else if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]){
            stringCode = @"已取消付款";
        }else if ([resultDic[@"resultStatus"] isEqualToString:@"6002"]){
            stringCode = @"网络连接错误";
        }
    }
    [self sendPayResult:payState];
}


#pragma mark - 模拟支付宝生成订单

#pragma mark - 模拟微信支付生成订单

@end
