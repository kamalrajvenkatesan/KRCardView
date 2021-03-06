#
# Be sure to run `pod lib lint KRCardView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KRCardView'
  s.version          = '2.1.1'
  s.summary          = 'Card view on bottom of view controller that can be access to view the content on card view'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
KRCardView is a view that allows to make a CardView / Bottom View on any UIViewController, The card view will lay on bottom of the screen, which can expand so user can access the content in card view
                       DESC

  s.homepage         = 'https://github.com/kamalrajvenkatesan/KRCardView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kamalraj venkatesan' => 'kamalrajv3@gmail.com' }
  s.source           = { :git => 'https://github.com/kamalrajvenkatesan/KRCardView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'

  s.source_files = 'KRCardView/**/*.{h,m,swift}'
  
  # s.resource_bundles = {
  #   'KRCardView' => ['KRCardView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
