# 初始化代码
# pod spec create 项目名

Pod::Spec.new do |s|

# 名称
  s.name             = 'YLPopView'
  s.version          = '0.0.1'
  s.summary          = '简单弹窗'

  s.description      = <<-DESC
		代码侵入低,使用方便的弹窗小工具
                       DESC

  s.homepage         = 'https://github.com/StudentLinn/YLPopView'
  s.license          = 'MIT'
  s.author           = { 'StudentLinn' => '792007074@qq.com' }
  s.source           = { :git => 'https://github.com/StudentLinn/YLPopView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '12.0'

  s.source_files = 'PopView/*'
  s.swift_version = '4.0'
  s.framework    = 'UIKit'
  s.dependency 'SnapKit'

end
