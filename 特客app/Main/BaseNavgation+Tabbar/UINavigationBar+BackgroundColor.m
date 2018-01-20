//
//  UINavigationBar+BackgroundColor.m
//  特客app
//
//  Created by 姚斯宁 on 2017/7/26.
//  Copyright © 2017年 姚斯宁. All rights reserved.
//

#import "UINavigationBar+BackgroundColor.h"

@implementation UINavigationBar (BackgroundColor)

static char overlayKey;

- (UIView *)overlay
{    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)lt_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        [self setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        [self setShadowImage:[[UIImage alloc] init]];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 64)];
        self.overlay.userInteractionEnabled = NO;
        [self insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}



@end
