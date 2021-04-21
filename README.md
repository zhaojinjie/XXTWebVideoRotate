# XXTWebVideoRotate

## 介绍
---
这个一个用于监听WKWebView中视频播放旋转，并同时支持自动旋转的UIViewController的分类，使用方法简单，并支持cocoaPod安装

## 安装 
``注意2.0.1版本后将UIWebView相关的内容进行了移除，如果想继续使用UIWebView的监听，请使用2.0.0版本 ``<br> 
**2.0.1**
```ruby
pod 'XXTWebVideoRotate'
```
**2.0.0**
```ruby
 pod 'XXTWebVideoRotate','2.0.0'
```

## 使用
### (1)在WKWebView的代理加载完成方法中添加:
 #### wkWebView:
 ///加载结束后调用<br>
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{<br> 
     [self observerWKWebViewVideoPlay:webView];<br> 
}<br> 
###（2）在viewDidDisappear移除监听
主要为了以防万一，不能进行监听的移除会导致很多的问题存在<br> 
-(void)viewDidDisappear:(BOOL)animated{<br> 
    [super viewDidDisappear:animated];<br> 
     //移除网页上的监听<br> 
    [self removeObserverWebViewVideoPlay ];<br> 
}<br> 

## Requirements

### iOS  9+

## Author

zhaoxuan, zhaoxuan0315@163.com

## License

XXTWebVideoRotate is available under the MIT license. See the LICENSE file for more info.
