//
//  CommonWebViewController+XXTVideoPlay.m
//  xxtnm_iOS_con
//
//  Created by 赵轩 on 2020/2/10.
//  Copyright © 2020 内蒙校信通. All rights reserved.
//

#import "UIViewController+XXTVideoPlay.h"
#import <objc/runtime.h>
@implementation UIViewController (XXTVideoPlay)
 
#pragma mark - public

// 监听网页上的视频播放
-(void)observerWebViewVideoPlay{
   ///点击了视频播放按钮，会进入系统原生的播放器
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginPlayVideo:) name:UIWindowDidResignKeyNotification  object:self.view.window];
  //点击原生的系统播放器的左上角的关闭按钮的回调
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endPlayVideo:) name:UIWindowDidBecomeHiddenNotification object:self.view.window];
}

///移除网页上的视频播放
-(void)removeObserverWebViewVideoPlay{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIWindowDidResignKeyNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIWindowDidBecomeHiddenNotification object:nil];
    [self endPlayVideo:nil];
}


#pragma mark - Notification
///点击了视频播放按钮，会进入系统原生的播放器
-(void)beginPlayVideo:(NSNotificationCenter *)noti{
    //如果是alertview或者actionsheet的话也会执行到这里，所以要判断一下
    if ([[UIApplication sharedApplication].keyWindow isMemberOfClass:[UIWindow class]]){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             if(!self.fullScreen && !self.clickCloseBtn){
                [self observerDeviceOrientationChange];
                [self toOrientation:UIInterfaceOrientationLandscapeRight];
             }else{
                self.clickCloseBtn=NO;
             }
        });
    }
}
///点击原生的系统播放器的左上角的关闭按钮的回调
-(void)endPlayVideo:(NSNotificationCenter *)noti{
    if(self.fullScreen){
        [self removeDeviceOrientationChange];
        [self toOrientation:UIInterfaceOrientationPortrait];
        self.clickCloseBtn=YES;
    }
}

///监听设备方向
-(void)observerDeviceOrientationChange{
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDeviceOrientationChange) name:UIDeviceOrientationDidChangeNotification object:nil];
    self.lastOrientation=UIInterfaceOrientationPortrait;
}
///移除设备方向改变的监听
-(void)removeDeviceOrientationChange{
    
    [[UIDevice currentDevice]endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

/**
*  屏幕方向发生变化会调用这里
*/

-(void)onDeviceOrientationChange{
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    if (orientation == UIDeviceOrientationFaceUp || orientation == UIDeviceOrientationFaceDown || orientation == UIDeviceOrientationUnknown ) { return; }
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown: {
            
        }
            break;
        case UIInterfaceOrientationPortrait: {  //竖屏
            if (self.fullScreen) {
                self.clickCloseBtn=YES;
                [self toOrientation:UIInterfaceOrientationPortrait];
            }
        }
            break;
        case UIInterfaceOrientationLandscapeLeft: { //横屏向左
            [self toOrientation:UIInterfaceOrientationLandscapeLeft];
            
        }
            break;
        case UIInterfaceOrientationLandscapeRight: {//横屏向右
            [self toOrientation:UIInterfaceOrientationLandscapeRight];
            
        }
            break;
        default:
            break;
    }
}
    
#pragma mark -屏幕旋转相关


/// 设置屏幕的旋转
/// @param orientation  旋转的方向
- (void)toOrientation:(UIInterfaceOrientation)orientation {
    UIApplication *application= [UIApplication sharedApplication];
    
    // 判断如果当前方向和要旋转的方向一致,那么不做任何操作
    if (self.lastOrientation == orientation) { return; }
     UIWindow *keyWindow = application.keyWindow;
    if(SystemVersion()<13){
        [application setStatusBarOrientation:orientation animated:NO];
    }
      if (orientation != UIInterfaceOrientationPortrait) {//横屏
          if(SystemVersion()>=13){
             [application setStatusBarHidden:YES];
          }
        
            keyWindow.bounds=CGRectMake(0, 0, ScreenHeight(), ScreenWidth());
            self.fullScreen=YES;
      }else{ //竖屏
          if(SystemVersion()>=13){
              [application setStatusBarHidden:NO];
          }
          keyWindow.bounds=CGRectMake(0, 0, ScreenWidth(),ScreenHeight());
          self.fullScreen=NO;
      }
      [UIView beginAnimations:nil context:nil];
    // 获取旋转状态条需要的时间:
      [UIView setAnimationDuration:0.3];
   
// 更改了状态条的方向,但是设备方向UIInterfaceOrientation还是正方向的,这就要设置给你播放视频的视图的方向设置旋转
    keyWindow.transform = [self getTransformRotationAngle:orientation];
    // 开始旋转
     [UIView commitAnimations];
    self.lastOrientation=orientation;
}

/**
 * 获取变换的旋转角度
 * @return 角度
 */
- (CGAffineTransform)getTransformRotationAngle:(UIInterfaceOrientation)orientation {
    // 根据要进行旋转的方向来计算旋转的角度
    if (orientation == UIInterfaceOrientationPortrait) {
        return CGAffineTransformIdentity;
    } else if (orientation == UIInterfaceOrientationLandscapeLeft){
        return CGAffineTransformMakeRotation(-M_PI_2);
    } else if(orientation == UIInterfaceOrientationLandscapeRight){
        return CGAffineTransformMakeRotation(M_PI_2);
    }
    return CGAffineTransformIdentity;
}


#pragma mark - const

CGFloat ScreenWidth(){
    return [UIScreen mainScreen].bounds.size.width;
}
CGFloat ScreenHeight(){
    return [UIScreen mainScreen].bounds.size.height;
}

float SystemVersion(){
    return [[UIDevice currentDevice].systemVersion floatValue];
}

#pragma mark -getter & setter
static void *XXTFullScreenKey = &XXTFullScreenKey;
- (void)setFullScreen:(BOOL)fullScreen{
    objc_setAssociatedObject(self, XXTFullScreenKey, @(fullScreen), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)fullScreen{
    return  [objc_getAssociatedObject(self, XXTFullScreenKey) boolValue];
}

static void *XXTLastOrientation = &XXTLastOrientation;
- (void)setLastOrientation:(UIInterfaceOrientation)lastOrientation{
    objc_setAssociatedObject(self, XXTLastOrientation, @(lastOrientation), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIInterfaceOrientation)lastOrientation{
    return  [objc_getAssociatedObject(self, XXTLastOrientation)integerValue];
}

static void *XXTClickCloseBtn = &XXTClickCloseBtn;
- (void)setClickCloseBtn:(BOOL)clickCloseBtn{
    objc_setAssociatedObject(self, XXTClickCloseBtn, @(clickCloseBtn), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)clickCloseBtn{
    return  [objc_getAssociatedObject(self, XXTClickCloseBtn)boolValue];
}


@end
