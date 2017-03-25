//
//  FZKBaseViewController.m
//  siruiDemo1
//
//  Created by czl on 2017/3/24.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBaseViewController.h"

@interface FZKBaseViewController ()

@end

@implementation FZKBaseViewController

+(instancetype)initVCWithStoryboardName:(NSString *)storyboardWithName;{

    
    return [[UIStoryboard storyboardWithName:storyboardWithName?storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}


@end
