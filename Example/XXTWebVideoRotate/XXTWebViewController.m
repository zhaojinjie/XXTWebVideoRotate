
//
//  XXTWebViewController.m
//  XXTWebVideoRotate_Example
//
//  Created by 赵轩 on 2020/2/29.
//  Copyright © 2020 zhaoxuan. All rights reserved.
//

#import "XXTWebViewController.h"
#import "UIViewController+XXTVideoPlay.h"
@interface XXTWebViewController ()<WKNavigationDelegate,WKUIDelegate>
@property(nonatomic,strong)WKWebView *videoWebView;
@end

@implementation XXTWebViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    ///开始监听网页上的播放
    self.videoWebView =[[WKWebView alloc]initWithFrame:self.view.bounds];
    self.videoWebView.navigationDelegate=self;
    self.videoWebView.UIDelegate=self;
    self.videoWebView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.videoWebView];
    [self loadWebView];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
     //移除网页上的监听
    [self removeObserverWebViewVideoPlay];
}

-(void)loadWebView{
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString: @"https://haokan.baidu.com/v?vid=13959996208383167676&pd=bjh&fr=bjhauthor&type=video"]];
    [self.videoWebView  loadRequest:request];
    
}

//MARK: -UIWebViewDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self observerWKWebViewVideoPlay:webView];
}

@end
