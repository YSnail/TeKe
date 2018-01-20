//
//  TakingNavigationController.m
//  特客app
//
//  Created by 姚斯宁 on 2017/7/26.
//  Copyright © 2017年 姚斯宁. All rights reserved.
//

#import "TakingNavigationController.h"
#import "UINavigationBar+BackgroundColor.h"

@interface TakingNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic, weak) id PopDelegate;

@end

@implementation TakingNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.PopDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
    
    [self.navigationBar lt_setBackgroundColor:[UIColor blackColor]];
    
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
    
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
}
//解决返回手势失效的问题
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = self.PopDelegate;
    }else{
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}
//push时隐藏tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - UIGestureRecognizerDelegate

//修复有水平方向滚动的ScrollView时边缘返回手势失效的问题
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}



@end
