


//
//  FZKPayViewController.m
//  siruiDemo1
//
//  Created by czl on 2017/3/24.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKCPayViewController.h"
#import "FZKPayManager.h"

@interface FZKCPayViewController ()

@end

@implementation FZKCPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 阿里支付
 
 @param sender
 */
- (IBAction)aliPayAction:(id)sender {
    //    支付测试支付串
    NSString *payParams = @"oukKUDLqfaQY0VFIm/WUX3SyuVa+6T+mFx07Fx93xMxpjWNVxWgSufwSIJSeIS4cTmH3D61Fk3IEMXD90JYh92WtHWch4MqsU4SpN/c90w/aelbXiTwX/050r7P2H8DN90XaOPACDgkIyjeyOio7tb789bMJHPQxzcZ1SOcc5o0FXIs6O11MH+dSus0OsPMfgS1v4YImRhIZZiFcD6zw8h14xm9WxyWS18W2N9Ma9toDER9J4pF10ot7HlYvUUMonABtLsVPEjGrJFO1JyBU3qFTk7BCn0H6j8hCAX7YtJ7mzA5Wc0SmQ8MDk3Sc4qW78dhrQKzZ54R33R3IsMxwtA==";
    
    [FZKPayManager payWithParams:payParams type:PayTypeALI];
}


/**
 微信支付
 
 @param sender
 */
- (IBAction)WXPayAction:(id)sender {
    
    //    支付测试字典
    NSMutableDictionary *dict = @{}.mutableCopy;
    //    IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    
    [dict setObject:@"wx5126f6a9301e1c9c" forKey:@"appid"];
    [dict setObject:@"1484624621" forKey:@"timestamp"];
    [dict setObject:@"1429161402" forKey:@"partnerid"];
    [dict setObject:@"wx201701171143429b0b01e21b0300034792" forKey:@"prepayid"];
    [dict setObject:@"BmDNVdbX4UEWCyuakh5k" forKey:@"noncestr"];
    [dict setObject:@"Sign=WXPay" forKey:@"package"];
    [dict setObject:@"59F6D5BC78114C288756154A8E34A7D7" forKey:@"sign"];
    [FZKPayManager payWithParams:dict type:PayTypeWINXIN];
}



@end
