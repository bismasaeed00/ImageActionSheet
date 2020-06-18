#
# Be sure to run `pod lib lint ImageActionSheet.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ImageActionSheet'
  s.version          = '1.0.0'
  s.summary          = 'iOS Native style action sheet with the option of showing icons. It is a complete implementation and does not use any private api of UIKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/bismasaeed00/ImageActionSheet'
  s.screenshots     = 'https://user-images.githubusercontent.com/16186934/83187499-87f88480-a12e-11ea-8a12-19e08cebb4dc.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Bisma Saeed' => 'bismasaeed00@gmail.com' }
  s.source           = { :git => 'https://github.com/Bisma Saeed/ImageActionSheet.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/bismasaeed00'

  s.ios.deployment_target = '11.0'

  s.source_files = 'ImageActionSheet/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ImageActionSheet' => ['ImageActionSheet/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
