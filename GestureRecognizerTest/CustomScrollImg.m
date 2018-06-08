//
//  CustomScrollImg.m
//  GestureRecognizerTest
//
//  Created by Mac on 2018/6/8.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CustomScrollImg.h"
@interface CustomScrollImg()

@property (nonatomic, strong) UIImageView *firstImgV;//第一张图片
@property (nonatomic, strong) UIImageView *secondImageV;
@property (nonatomic, strong) NSString *firstStr;
@property (nonatomic, strong) NSString *secondStr;

@end
@implementation CustomScrollImg
//默认是第一个图片,要是两个图片secondstr.length不为0
- (CustomScrollImg *)initWithFrame:(CGRect)frame withfirstImg:(NSString *)firstStr withSecondImg:(NSString *)secondStr{
    self = [super initWithFrame:frame];
    if (self) {
        _firstStr = firstStr;
        _secondStr = secondStr;
        [self addSubUI];
    }
    return self;
}
- (void)addSubUI{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    //设置内容大小
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width*1.001, _scrollView.frame.size.height*1.001);
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.bouncesZoom = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.minimumZoomScale = 1;
    _scrollView.maximumZoomScale = 3;
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.numberOfTapsRequired=2;
    [_scrollView addGestureRecognizer:tapGesture];
    [self addSubview:_scrollView];
    _firstImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    _firstImgV.backgroundColor = [UIColor whiteColor];
    _firstImgV.image = [UIImage imageNamed:_firstStr];
    [_scrollView addSubview:_firstImgV];
    if (_secondStr.length > 0) {
        _sccondScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 220, 200, 200)];
        //设置内容大小
        _sccondScrollview.contentSize = CGSizeMake(_sccondScrollview.frame.size.width*1.001, _sccondScrollview.frame.size.height*1.001);
        _sccondScrollview.delegate = self;
        _sccondScrollview.bounces = NO;
        _sccondScrollview.bouncesZoom = NO;
        _sccondScrollview.showsVerticalScrollIndicator = NO;
        _sccondScrollview.showsHorizontalScrollIndicator = NO;
        _sccondScrollview.minimumZoomScale = 1;
        _sccondScrollview.maximumZoomScale = 3;
        UITapGestureRecognizer *secondtapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
        secondtapGesture.numberOfTapsRequired=2;
        [_sccondScrollview addGestureRecognizer:secondtapGesture];
        [self addSubview:_sccondScrollview];
        _secondImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _sccondScrollview.frame.size.width, _sccondScrollview.frame.size.height)];
        _secondImageV.image = [UIImage imageNamed:_secondStr];
        [_sccondScrollview addSubview:_secondImageV];
    }
}


#pragma mark 控制图片放大缩小
//放大缩小
-(void)handleTapGesture:(UIGestureRecognizer*)sender
{
    if (sender.view == _scrollView) {
        if(_scrollView.zoomScale > 1.0){
            [_scrollView setZoomScale:1.0 animated:YES];
            [_sccondScrollview setZoomScale:1.0 animated:YES];
        }else{
            [_scrollView setZoomScale:3.0 animated:YES];
            [_sccondScrollview setZoomScale:3.0 animated:YES];
        }
    }
    if (sender.view == _sccondScrollview) {
        if(_sccondScrollview.zoomScale > 1.0){
            [_scrollView setZoomScale:1.0 animated:YES];
            [_sccondScrollview setZoomScale:1.0 animated:YES];
        }else{
            [_scrollView setZoomScale:3.0 animated:YES];
            [_sccondScrollview setZoomScale:3.0 animated:YES];
        }
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView) {
        return _firstImgV;
    }
    if (scrollView == _sccondScrollview) {
        return _secondImageV;
    }
    return nil;
}
//当有两张图片时,控制一张图片随另一张图片的变化而变化
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    if (scrollView == _scrollView) {
        _sccondScrollview.zoomScale = scrollView.zoomScale;
        _sccondScrollview.contentOffset = scrollView.contentOffset;
    }
    if (scrollView == _sccondScrollview) {
        _scrollView.zoomScale = scrollView.zoomScale;
        _scrollView.contentOffset = scrollView.contentOffset;
    }
}
//当有两张图片时,一张图片随着另一张的位置变化而改变位置信息
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _scrollView) {
        _sccondScrollview.contentOffset = scrollView.contentOffset;
    }
    if (scrollView == _sccondScrollview) {
        _scrollView.contentOffset = scrollView.contentOffset;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
