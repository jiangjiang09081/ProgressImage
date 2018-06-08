//
//  ViewController.m
//  GestureRecognizerTest
//
//  Created by Mac on 2018/5/23.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "CustomScrollImg.h"
#import "CustomDrogView.h"
@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *firstImgV;
//@property (nonatomic, strong) CustomScrollImg *imgView;

@property (nonatomic, strong) CustomDrogView *imgView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    CustomScrollImg *imgView = [[CustomScrollImg alloc] initWithFrame:CGRectMake(50, 100, 200, 420) withfirstImg:@"huahuagongzhu12.jpg" withSecondImg:nil];
//    imgView.backgroundColor = [UIColor whiteColor];
//    imgView.scrollView.frame = CGRectMake(0, 0, 200, 200);
//    imgView.sccondScrollview.frame = CGRectMake(0, 220, 200, 200);
//    _imgView = imgView;
//    [self.view addSubview:imgView];
    CustomDrogView *imgView = [[CustomDrogView alloc] initWithFrame:CGRectMake(50, 100, 200, 500)];
    imgView.backgroundColor = [UIColor whiteColor];
    _imgView = imgView;
    [self.view addSubview:imgView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
