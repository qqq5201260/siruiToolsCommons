//
//  FZKCHTTPDNSManager.m
//  Commons
//
//  Created by czl on 2017/3/25.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKCHTTPDNSManager.h"

@implementation FZKCHTTPDNSManager

+(void)registerAliHTTPDNSCount:(NSInteger)count{

    HttpDnsService *httpdns = [HttpDnsService sharedInstance];
    // 设置AccoutID，当您开通HTTPDNS服务时，您可以在控制台获取到您对应的Accout ID信息
    [httpdns setAccountID:count];
    // 允许返回过期的IP
    [httpdns setExpiredIPEnabled:YES];
    // 打开HTTPDNS Log，线上建议关闭
    [httpdns setLogEnabled:YES];
    
    NSArray *preResolveHosts = @[ @"www.chinapke.com", @"www.taobao.com", @"gw.alicdn.com", @"www.tmall.com", @"dou.bz"];
    // NSArray* preResolveHosts = @[@"pic1cdn.igetget.com"];
    // 设置预解析域名列表
    [httpdns setPreResolveHosts:preResolveHosts];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *originalUrl = @"http://www.chinapke.com";
        NSURL* url = [NSURL URLWithString:originalUrl];
        NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
        // 同步接口获取IP
        NSString* ip = [httpdns getIpByHostAsync:url.host];
        if (ip) {
            // 通过HTTPDNS获取IP成功，进行URL替换和HOST头设置
            NSRange hostFirstRange = [originalUrl rangeOfString: url.host];
            if (NSNotFound != hostFirstRange.location) {
                NSString* newUrl = [originalUrl stringByReplacingCharactersInRange:hostFirstRange withString:ip];
                request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:newUrl]];
                // 设置请求HOST字段
                [request setValue:url.host forHTTPHeaderField:@"host"];
            }
        }

    });
   }

@end
