//
//  CustomScrollImg.h
//  GestureRecognizerTest
//
//  Created by Mac on 2018/6/8.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomScrollImg : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIScrollView *sccondScrollview;

- (CustomScrollImg *)initWithFrame:(CGRect)frame withfirstImg:(NSString *)firstStr withSecondImg:(NSString *)secondStr;

@end
