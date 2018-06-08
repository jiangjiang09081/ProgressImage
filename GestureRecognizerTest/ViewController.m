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
@property (nonatomic, strong) CustomScrollImg *imgView;

//@property (nonatomic, strong) CustomDrogView *imgView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CustomScrollImg *imgView = [[CustomScrollImg alloc] initWithFrame:CGRectMake(50, 100, 300, 420) withfirstImg:@"huahuagongzhu12.jpg" withSecondImg:@"huahuagongzhu08.jpg"];
    imgView.backgroundColor = [UIColor whiteColor];
    imgView.scrollView.frame = CGRectMake(0, 0, 150, 200);
    imgView.sccondScrollview.frame = CGRectMake(150, 0, 150, 200);
    _imgView = imgView;
    [self.view addSubview:imgView];
    
    
//    CustomDrogView *imgView = [[CustomDrogView alloc] initWithFrame:CGRectMake(50, 100, 200, 500)];
//    imgView.backgroundColor = [UIColor whiteColor];
//    _imgView = imgView;
//    [self.view addSubview:imgView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
