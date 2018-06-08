//
//  CustomScrollImg.m
//  GestureRecognizerTest
//
//  Created by Mac on 2018/6/8.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CustomScrollImg.h"
#define ratio 2

@interface CustomScrollImg()

@property (nonatomic, strong) UIImageView *firstImgV;//第一张图片
@property (nonatomic, strong) UIImageView *secondImageV;
@property (nonatomic, strong) NSString *firstStr;
@property (nonatomic, strong) NSString *secondStr;

@property (nonatomic, strong) UIView *miniView;
@property (nonatomic, strong) UIImageView *miniImg;
@property (nonatomic, strong) UIView *miniIndicator;
@property (nonatomic, strong) UISlider *silder;

@property (nonatomic) BOOL isSlider;
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
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 150, 200)];
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
        _sccondScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(150, 0, 150, 200)];
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
    _miniView = [[UIView alloc] initWithFrame:CGRectMake(0, 250, _scrollView.frame.size.width / ratio, _scrollView.frame.size.height / ratio)];
    _miniView.backgroundColor = [UIColor redColor];
    _miniView.clipsToBounds = YES;
    [self addSubview:_miniView];
    _miniImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _miniView.frame.size.width, _miniView.frame.size.height)];
    _miniImg.image = [UIImage imageNamed:@"huahuagongzhu12.jpg"];
    [_miniView addSubview:_miniImg];
    _miniIndicator = [[UIView alloc]initWithFrame:CGRectMake(
                                                             self.scrollView.contentOffset.x/ratio/self.scrollView.zoomScale,
                                                             self.scrollView.contentOffset.y/ratio/self.scrollView.zoomScale,
                                                             _miniView.frame.size.width/self.scrollView.zoomScale,
                                                             _miniView.frame.size.height/self.scrollView.zoomScale)];
    _miniIndicator.layer.borderWidth = 1.0;
    _miniIndicator.layer.borderColor = [UIColor blueColor].CGColor;
    _miniIndicator.backgroundColor = [UIColor clearColor];
    [_miniView addSubview:_miniIndicator];
    _silder = [[UISlider alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_miniView.frame), 200, 50)];
    _silder.maximumValue = _scrollView.maximumZoomScale;
    _silder.minimumValue = _scrollView.minimumZoomScale;
    _silder.value = self.scrollView.zoomScale;
    [_silder setContinuous:YES];
    _silder.thumbTintColor = [UIColor blueColor];
    _silder.maximumTrackTintColor = [UIColor grayColor];
    _silder.minimumTrackTintColor = [UIColor redColor];
    [_silder addTarget:self action:@selector(silderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_silder];
    UIButton *miniViewButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _miniView.frame.size.width, _miniView.frame.size.height)];
    [miniViewButton addTarget:self action:@selector(dragBegan:withEvent:) forControlEvents:UIControlEventTouchDragInside | UIControlEventTouchDown];
    miniViewButton.clipsToBounds = YES;
    [_miniView addSubview:miniViewButton];
}

//局部指示图坐标
- (void)dragBegan:(UIButton *)c withEvent:(UIEvent *)ev{
    UITouch *touch = [[ev allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:_miniView];
    if(touchPoint.x<0)
    {
        touchPoint.x=0;
    }
    if(touchPoint.y<0)
    {
        touchPoint.y=0;
    }
    if(touchPoint.y + _miniView.frame.size.height/self.scrollView.zoomScale > _miniView.frame.size.height)
    {
        touchPoint.y = _miniView.frame.size.height - _miniView.frame.size.height/self.scrollView.zoomScale;
    }
    
    if(touchPoint.x + _miniView.frame.size.width/self.scrollView.zoomScale > _miniView.frame.size.width)
    {
        touchPoint.x = _miniView.frame.size.width - _miniView.frame.size.width/self.scrollView.zoomScale;
    }
    
    _miniIndicator.frame = CGRectMake(touchPoint.x, touchPoint.y, _miniView.frame.size.width/self.scrollView.zoomScale, _miniView.frame.size.height/self.scrollView.zoomScale);
    
    [self.scrollView setContentOffset:CGPointMake(touchPoint.x*ratio*self.scrollView.zoomScale, touchPoint.y*ratio*self.scrollView.zoomScale) animated:NO];
    _sccondScrollview.contentOffset = _scrollView.contentOffset;
}


//滑动条滑动
- (void)silderValueChanged:(UISlider *)silder{
    [_scrollView setZoomScale:silder.value animated:YES];
}
#pragma mark 控制图片放大缩小
//放大缩小
-(void)handleTapGesture:(UIGestureRecognizer*)sender
{
    if (sender.view == _scrollView) {
        if(_scrollView.zoomScale > 1.0){
            [_scrollView setZoomScale:1.0 animated:YES];
        }else{
            [_scrollView setZoomScale:3.0 animated:YES];
        }
    }
    if (sender.view == _sccondScrollview) {
        if(_sccondScrollview.zoomScale > 1.0){
            [_sccondScrollview setZoomScale:1.0 animated:YES];
        }else{
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
    _isSlider = NO;
    if (scrollView == _scrollView) {
        _sccondScrollview.zoomScale = scrollView.zoomScale;
        _sccondScrollview.contentOffset = scrollView.contentOffset;
    }
    if (scrollView == _sccondScrollview) {
        _scrollView.zoomScale = scrollView.zoomScale;
        _scrollView.contentOffset = scrollView.contentOffset;
    }
    _miniIndicator.frame = CGRectMake(_miniIndicator.frame.origin.x
                                      , _miniIndicator.frame.origin.y,
                                      _miniView.frame.size.width/scrollView.zoomScale,
                                      _miniView.frame.size.height/scrollView.zoomScale);
    _silder.value = scrollView.zoomScale;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _isSlider = YES;
}
//当有两张图片时,一张图片随着另一张的位置变化而改变位置信息
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _miniIndicator.frame =
        CGRectMake(_scrollView.contentOffset.x/ratio/scrollView.zoomScale,
                   _scrollView.contentOffset.y/ratio/scrollView.zoomScale,
                   _miniIndicator.frame.size.width,
                   _miniIndicator.frame.size.height);
//    NSLog(@"%@", NSStringFromCGRect(_miniIndicator.frame));
    if (_isSlider) {
        if (scrollView == _scrollView) {
            _sccondScrollview.contentOffset = _scrollView.contentOffset;
        }
        if (scrollView == _sccondScrollview) {
            _scrollView.contentOffset = _sccondScrollview.contentOffset;
        }
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
