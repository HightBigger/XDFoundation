#
# Be sure to run `pod lib lint XDFoundation.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XDFoundation'
  s.version          = '0.1.0'
  s.summary          = '常用方法工具类封装.'
  s.homepage         = 'https://github.com/HightBigger/XDFoundation'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'HightBigger' => '435021572@qq.com' }
  s.source           = { :git => 'https://github.com/HightBigger/XDFoundation.git', :tag => s.version.to_s }
  s.module_map   = 'XDFoundation.modulemap'
  s.ios.deployment_target = '9.0'
  s.source_files = 'XDFoundation/Classes/**/*.{h,m}'
  
  # s.resource_bundles = {
  #   'XDFoundation' => ['XDFoundation/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
