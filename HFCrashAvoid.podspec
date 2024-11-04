#
# Be sure to run `pod lib lint CrashHande.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HFCrashAvoid'
  s.version          = '0.1.0'
  s.summary          = '防崩溃'
  s.description      = <<-DESC
用户防止崩溃框架
                       DESC
  s.homepage         = 'https://github.com/Components-iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liuhongfei' => '13718045729@163.com' }
  s.source           = { :git => 'https://github.com/Components-iOS/HFCrashAvoid.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'HFCrashAvoid/Classes/**/*'
end
