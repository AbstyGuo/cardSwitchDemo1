//
//  GAPGuideViewController.m
//  BangTravel
//
//  Created by YaoKaige on 16/1/15.
//  Copyright © 2016年 Beijing Gan Servant Software Co., Ltd. All rights reserved.
//

#import "GAPGuideViewController.h"
#import "HXCardSwitchView.h"

#define mainScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface GAPGuideViewController () <UIScrollViewDelegate,HXCardSwitchViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel *pageTitleLabel;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet HXCardSwitchView *scrollView;

@property (nonatomic, strong) NSArray *guideImageViews;
@property (nonatomic, strong) NSArray *imagesTitleNames;

@end

@implementation GAPGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    
    [self setupScrollView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    segue.destinationViewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

#pragma mark -
- (void)setupScrollView {

    NSMutableArray *imageViews = [NSMutableArray array];
    for(int i=0; i<4; i++) {
        NSString *name = [NSString stringWithFormat:@"guide%d", i+1];
        UIImage *image = [UIImage imageNamed:name];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        CGSize size = image.size;
        CGFloat imageH = mainScreenHeight - 204;
        CGFloat imageW = imageH * (size.width/size.height);
        imageView.frame = CGRectMake(0, 35,imageW,imageH);
//        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageViews addObject:imageView];
    }
    self.guideImageViews = imageViews;
    [_scrollView setCardSwitchViewAry:imageViews delegate:self];
    self.imagesTitleNames = @[@"管理我的旅行相册",
                              @"分享相册结识玩伴",
                              @"找咨询师定制方案",
                              @"记录我的旅行数据"];
    self.pageTitleLabel.text = [self.imagesTitleNames firstObject];
    self.pageControl.currentPage = 0;
}

- (void)dismissFromParentVC {
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.view.alpha = 0.0f;
        self.view.transform = CGAffineTransformMakeScale(2, 2);
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}

#pragma mark - UIScollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    self.pageControl.currentPage = page;
    self.pageTitleLabel.text = self.imagesTitleNames[page];
}

-(void)cardSwitchViewDidScroll:(HXCardSwitchView *)cardSwitchView index:(NSInteger)index{
    self.pageControl.currentPage = index;
    self.pageTitleLabel.text = self.imagesTitleNames[index];
}
- (IBAction)call:(id)sender {
    if ([UIApplication instancesRespondToSelector:@selector(canOpenURL:)])  {
           NSString *telNumber = [NSString stringWithFormat:@"tel:%@",@"15010556211"];
        
           NSURL *aURL = [NSURL URLWithString: telNumber];
        if ([[UIApplication sharedApplication] canOpenURL:aURL])
        
            
            
               {

                      [[UIApplication sharedApplication] openURL:aURL];
                }
    }
}

@end
