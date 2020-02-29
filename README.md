# XXTWebVideoRotate

## 介绍
-
这个一个用于监听UIWebView和WKWebView中视频播放旋转，并同时支持自动旋转的UIViewController的分类，使用方法简单，并支持cocoaPod安装

## 安装 

```ruby
pod 'XXTWebVideoRotate'
```

## 使用
### (1)在Controller中的viewDidLoad方法中添加:
-(void)viewDidLoad {<br> 
      [super viewDidLoad];<br> 
       ///开始监听网页上的播放<br> 
      [self observerWebViewVideoPlay];<br> 
   }<br> 
 ### 或者在你需要监听网页上的播放的地方添加即可<br> 
### (2)最好在viewDidDisappear移除监听<br> 

-(void)viewDidDisappear:(BOOL)animated{<br> 
    [super viewDidDisappear:animated];<br> 
     //移除网页上的监听<br> 
    [self removeObserverWebViewVideoPlay ];<br> 
}<br> 

## Requirements

### iOS  8+

## Author

zhaoxuan, zhaoxuan0315@163.com

## License

XXTWebVideoRotate is available under the MIT license. See the LICENSE file for more info.
