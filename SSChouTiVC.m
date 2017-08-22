//
//  SSChouTiVC.m
//  抽屉效果Demo
//
//  Created by jssName on 16/3/22.
//  Copyright © 2016年 jssName. All rights reserved.
//
#define  screen [UIScreen mainScreen].bounds.size

//加上导航栏最左边的设置图标
#define build_nav_leftButton(imageName)   \
UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];\
[button setFrame:CGRectMake(0, 0, 40, 40)];\
[button setTitle:@"" forState:UIControlStateNormal];\
[button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];\
[button addTarget:self action:@selector(navLeftDown:) forControlEvents:UIControlEventTouchUpInside];\
UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];\
self.navigationItem.leftBarButtonItem = barItem;


#import "SSChouTiVC.h"

@interface SSChouTiVC ()<UIGestureRecognizerDelegate>

@end

@implementation SSChouTiVC
{
    CGFloat xValue;//移动过程中的累计量
   
    NSString *localStr; //记录当前的位置  在左边还是在右边
    
    UIView *leftView;
    UIView *mainView;
}

//单例
+ (SSChouTiVC *)sharedManager {
    
    static SSChouTiVC *sharedAccountManagerInstance = nil;
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        
        sharedAccountManagerInstance = [[self alloc] init];
        
    });
    
    return sharedAccountManagerInstance;
    
}


- (void)viewDidAppear:(BOOL)animated{
        build_nav_leftButton(@"");
    /**
     *  注意叠加顺序   leftview在mainView下面
     */
    leftView=_leftVC.view;
    mainView=_mainVC.view;
    
    
    leftView.frame=CGRectMake(0, 0, screen.width, screen.height);
    mainView.frame=CGRectMake(0, 0, screen.width, screen.height);
    
    mainView.userInteractionEnabled=YES;
    
    [self.view addSubview:leftView];
    [self.view addSubview:mainView];
    //设置拖拉
    [self buildRecode:mainView];
    
    
    
}

/**
 *  设置拖拉事件
 */
- (void)buildRecode:(UIView *)_view{
    _pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panHandel:)];
    [_view addGestureRecognizer:_pan];

}
#pragma 拖动
//拖动
- (IBAction)panHandel:(UIPanGestureRecognizer *)sender {
    
    CGPoint point =   [sender translationInView:sender.view];
    
//    NSLog(@"x--:%f ",point.x);
//    NSLog(@"xValue--:%f --%f",xValue,screen.width);
    
    CGRect lb_Frame = mainView.frame;
    lb_Frame.origin.x=lb_Frame.origin.x+point.x;
    mainView.frame=lb_Frame;
    //累计拖动的x
    xValue = xValue+point.x;
    
    
    [sender setTranslation:CGPointZero inView:sender.view];
    if ((sender.state == UIGestureRecognizerStateEnded)) {
        NSLog(@"end");
        if ([localStr isEqualToString:@""] || localStr == nil) {
            localStr=@"left";
        }
        CGFloat compareValue =[localStr isEqualToString:@"left"]?(screen.width/2):(screen.width/2-50);
        
        
        if ([localStr isEqualToString:@"left"]) {
            if (xValue<0) {//已经在左边－－－继续左拉 就return
                [UIView animateWithDuration:1 animations:^{
                    CGRect lb_Frame = mainView.frame;
                    lb_Frame.origin.x=0;
                    mainView.frame=lb_Frame;
                }];
                
                localStr = @"left";
                return;
            }
            if (fabs(xValue)>compareValue) {
                NSLog(@"compareValue--%f",compareValue);
                [UIView animateWithDuration:1 animations:^{
                    CGRect currentView_Frame = mainView.frame;
                    currentView_Frame.origin.x=screen.width-50;
                    mainView.frame=currentView_Frame;
                }];
                //状态切换
                localStr = @"right";
                NSLog(@"localStr---%@",localStr);
            }else{
                //x归零
                [UIView animateWithDuration:1 animations:^{
                    CGRect lb_Frame = mainView.frame;
                    lb_Frame.origin.x=0;
                    mainView.frame=lb_Frame;
                }];
                
                localStr = @"left";
                NSLog(@"localStr---%@",localStr);
            }
            xValue = 0.0;//清零
            
        }else{
            //在右边
            if (fabs(xValue)>compareValue) {
                
                //x归零
                [UIView animateWithDuration:1 animations:^{
                    CGRect lb_Frame = mainView.frame;
                    lb_Frame.origin.x=0;
                    mainView.frame=lb_Frame;
                }];
                
                localStr = @"left";
                NSLog(@"localStr---%@",localStr);
            }else{
                [UIView animateWithDuration:1 animations:^{
                    CGRect currentView_Frame = mainView.frame;
                    currentView_Frame.origin.x=screen.width-50;
                    mainView.frame=currentView_Frame;
                }];
                //状态切换
                localStr = @"right";
                NSLog(@"localStr---%@",localStr);
                
            }
            xValue = 0.0;//清零
        }
        
    }

}



- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



//返回按钮
- (void)navLeftDown:(id)sender{
}

@end
