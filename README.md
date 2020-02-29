# XXTWebVideoRotate

## 介绍

这个一个用于监听UIWebView和WKWebView中视频播放的UIViewController的分类，使用方法简单，并支持cocoaPod安装

## 安装 

```ruby
pod 'XXTWebVideoRotate'
```

## 使用
（1）在Controller中的viewDidLoad方法中添加:\n
- (void)viewDidLoad {\n
        [super viewDidLoad];
          ///开始监听网页上的播放
          [self observerWebViewVideoPlay];
   }
   或者在你需要监听网页上的播放的地方添加即可
（2）最好在viewDidDisappear移除监听

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
     //移除网页上的监听
    [self removeObserverWebViewVideoPlay ];
}

## Requirements

 iOS  8+

## Author

zhaoxuan, zhaoxuan0315@163.com

## License

XXTWebVideoRotate is available under the MIT license. See the LICENSE file for more info.
