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
 注册httpdns 服务器

 @param count 设置账户
 
 */
+(void)registerAliHTTPDNSCount:(NSInteger)count;

@end
