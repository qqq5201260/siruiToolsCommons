//
//  FZKCHTTPDNSManager.h
//  Commons
//
//  Created by czl on 2017/3/25.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlicloudHttpDNS/AlicloudHttpDNS.h>

@interface FZKCHTTPDNSManager : NSObject


/**
 当前域名IP地址
 */
@property (nonatomic,copy)NSString *ip;


/**
 预解析域名数组 //@[ @"www.chinapke.com", @"www.taobao.com", @"gw.alicdn.com", @"www.tmall.com", @"dou.bz"]
 */
@property (nonatomic,copy)NSArray *preResolveHosts;

/**
 单利http管理工具

 @return 当前类
 */
+(instancetype)shareHTTPDNSManager;

/**
 注册httpdns 服务器

 @param count httpdns 账户
 @param resolveHost 预解析域名"http://www.taobao.com" 或者 @"https://www.tmall.com"
 
 */
+(void)registerAliHTTPDNSCount:(NSInteger)count preResolveHost:(NSString *)resolveHost;


/**
 根据域名获取IP

 @param host 域名
 @return 相关域名IP
 */
+ (NSString *)getIPWithHost:(NSString *)host;

@end
