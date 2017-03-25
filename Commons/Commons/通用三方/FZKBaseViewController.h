//
//  FZKBaseViewController.h
//  siruiDemo1
//
//  Created by czl on 2017/3/24.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FZKBaseViewController : UIViewController


/**
 如果是storyboard 采用这种方式生成vc

 @param storyboardWithName storyboardWithName  默认为Main.storyboard
 @return vc
 */
+(instancetype)initVCWithStoryboardName:(NSString *)storyboardWithName;

@end
