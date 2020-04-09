//
//  CommonWebViewController+XXTVideoPlay.h
//  xxtnm_iOS_con
//
//  Created by 赵轩 on 2020/2/10.
//  Copyright © 2020 内蒙校信通. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (XXTVideoPlay)
///是否当前处于全屏状态
@property(nonatomic,assign)BOOL fullScreen;
///记录上一次屏幕旋转的方向
@property(nonatomic,assign)UIInterfaceOrientation lastOrientation;
///监听webview的视频播放
-(void)observerWebViewVideoPlay;
///移除网页上的视频播放的监听
-(void)removeObserverWebViewVideoPlay;


@end

NS_ASSUME_NONNULL_END
