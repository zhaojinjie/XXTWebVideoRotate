#
# Be sure to run `pod lib lint XXTWebVideoRotate.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XXTWebVideoRotate'
  s.version          = '1.0.3'
  s.summary          = '一个针对网页中的视频播放进行横屏操作的分类'

  s.description      = <<-DESC
  可以针对webView和wkwebView中视频播放，当点击播放按钮后可进行自动横屏，并且可以检测到屏幕旋转时进行
     自动旋转
                       DESC

  s.homepage         = 'https://github.com/zhaojinjie/XXTWebVideoRotate'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhaoxuan' => 'zhaoxuan0315@163.com' }
  s.source           = { :git => 'https://github.com/zhaojinjie/XXTWebVideoRotate.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'XXTWebVideoRotate/Classes/*.{h,m}'

end
