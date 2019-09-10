#
# Be sure to run `pod lib lint RickBaseLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RickBaseLib'
  s.version          = '0.0.8'
  s.summary          = 'iOS Project Base Library'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  iOS Project Base Library Pod
                       DESC

  s.homepage         = 'https://github.com/RickwangF/RickBaseLib'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wangweiyu' => 'woshiwwy16@126.com' }
  s.source           = { :git => 'https://github.com/RickwangF/RickBaseLib.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'RickBaseLib/Classes/**/*'
  s.requires_arc = true

end
