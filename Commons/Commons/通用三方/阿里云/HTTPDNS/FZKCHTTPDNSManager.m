//
//  FZKCHTTPDNSManager.m
//  Commons
//
//  Created by czl on 2017/3/25.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKCHTTPDNSManager.h"


@implementation FZKCHTTPDNSManager

+ (NSArray *)ResolveHostsCofig{
//@[ @"www.chinapke.com", @"www.taobao.com", @"gw.alicdn.com", @"www.tmall.com", @"dou.bz"]
    return @[];
}

+ (instancetype)shareHTTPDNSManager{
    static FZKCHTTPDNSManager *install = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        install = [[self alloc]init];
    });
    return install;
}

+ (void)registerAliHTTPDNSCount:(NSInteger)count preResolveHost:(NSString *)resolveHost{

    // 初始化HTTPDNS
    HttpDnsService *httpdns = [HttpDnsService sharedInstance];
    
    // 设置AccoutID
    [httpdns setAccountID:count];
    
    // 为HTTPDNS服务设置降级机制
//    [httpdns setDelegateForDegradationFilter:(id < HttpDNSDegradationDelegate >)self];
    // 允许返回过期的IP
    [httpdns setExpiredIPEnabled:YES];
    // 打开HTTPDNS Log，线上建议关闭
//    [httpdns setLogEnabled:YES];

    // 设置预解析域名列表
    [httpdns setPreResolveHosts:[[self shareHTTPDNSManager] preResolveHosts]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [FZKCHTTPDNSManager shareHTTPDNSManager].ip = [FZKCHTTPDNSManager getIPWithHost:resolveHost];
    });
    
        /**
         * 异步接口获取IP
         * 为了适配IPv6的使用场景，我们使用 `-[HttpDnsService getIpByHostAsyncInURLFormat:]` 接口
         * 注意：当您使用IP形式的URL进行网络请求时，IPv4与IPv6的IP地址使用方式略有不同：
         *         IPv4: http://1.1.1.1/path
         *         IPv6: http://[2001:db8:c000:221::]/path
         * 因此我们专门提供了适配URL格式的IP获取接口 `-[HttpDnsService getIpByHostAsyncInURLFormat:]`
         * 如果您只是为了获取IP信息而已，可以直接使用 `-[HttpDnsService getIpByHostAsync:]`接口
         */
        
//        NSString *ip = [httpdns getIpByHostAsyncInURLFormat:url.host];
//        NSString *ips = [httpdns getIpByHostAsync:url.host];
//     NSLog(@"-----------------------------------------------------------------------------------\n%@,%@\n",[httpdns getIpByHostAsyncInURLFormat:url.host],[httpdns getIpByHostAsync:url.host]);
//        if (ip) {
//            // 通过HTTPDNS获取IP成功，进行URL替换和HOST头设置
//            NSLog(@"Get IP(%@) for host(%@) from HTTPDNS Successfully!", ip, url.host);
//            NSRange hostFirstRange = [originalUrl rangeOfString:url.host];
//            if (NSNotFound != hostFirstRange.location) {
//                NSString *newUrl = [originalUrl stringByReplacingCharactersInRange:hostFirstRange withString:ip];
//                NSLog(@"New URL: %@", newUrl);
//                request.URL = [NSURL URLWithString:newUrl];
//                [request setValue:url.host forHTTPHeaderField:@"host"];
//            }
//        }
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    
//        NSLog(@"=========================================================\n%@,%@\n",[httpdns getIpByHostAsyncInURLFormat:url.host],[httpdns getIpByHostAsync:url.host]);
//    });

    

}

+ (NSString *)getIPWithHost:(NSString *)host{

    NSString *originalUrl = host;
    NSURL *url = [NSURL URLWithString:originalUrl];
    [FZKCHTTPDNSManager shareHTTPDNSManager].ip = [[HttpDnsService sharedInstance] getIpByHostAsyncInURLFormat:url.host];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
   return [FZKCHTTPDNSManager shareHTTPDNSManager].ip;
}
@end
