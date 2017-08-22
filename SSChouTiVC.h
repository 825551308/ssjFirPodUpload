//
//  SSChouTiVC.h
//  抽屉效果Demo
//
//  Created by jssName on 16/3/22.
//  Copyright © 2016年 jssName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface SSChouTiVC : BaseViewController
@property (nonatomic , strong) UIViewController *leftVC;//左拉出来的菜单
@property (nonatomic , strong) UIViewController *mainVC;//根界面

@property (nonatomic , strong) UIPanGestureRecognizer *pan;

//单例
+ (SSChouTiVC *)sharedManager;
@end
