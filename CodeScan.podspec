#
# Be sure to run `pod lib lint CodeScan.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'CodeScan'
s.version          = '1.0.11'
s.summary          = 'A helper framework to read Barcodes and QRCodes'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
This frameworks help to read all kind of Barcodes and QR codes with minimum resource utilization and with minimal time. A focus are which helps you to bounds your scan region.
DESC

s.homepage         = 'https://github.com/sarathraveendran-litmus7/CodeScanner'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'sarathraveendran-litmus7' => 'Sarath Raveendran' }
s.source           = { :git => 'https://github.com/sarathraveendran-litmus7/CodeScanner.git', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '11.0'
s.swift_version = '5.0'

s.source_files = 'CodeScan/Classes/**/*'
#s.resource_bundles = {'Asset' => ['CodeScan/Classes/Asset.bundle']}

# s.public_header_files = 'Pod/Classes/**/*.h'
s.frameworks = 'UIKit', 'AVKit', 'Vision'
# s.dependency 'AFNetworking', '~> 2.3'
end
