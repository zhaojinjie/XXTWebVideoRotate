
//
//  XXTWebViewController.m
//  XXTWebVideoRotate_Example
//
//  Created by 赵轩 on 2020/2/29.
//  Copyright © 2020 zhaoxuan. All rights reserved.
//

#import "XXTWebViewController.h"
#import <UIViewController+XXTVideoPlay.h>
@interface XXTWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *videoWebView;

@end

@implementation XXTWebViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    ///开始监听网页上的播放
    [self observerWebViewVideoPlay];
    self.videoWebView.scalesPageToFit=YES;
    self.videoWebView.backgroundColor=[UIColor whiteColor];
    self.videoWebView.allowsInlineMediaPlayback = YES;
    self.videoWebView.mediaPlaybackRequiresUserAction=NO;
    [self loadWebView];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
     //移除网页上的监听
    [self removeObserverWebViewVideoPlay ];
}

-(void)loadWebView{
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:    @"https://hezhibo.migucloud.com/play/dnTA6bo7Vgc"]];
    [self.videoWebView  loadRequest:request];
    
}


@end
