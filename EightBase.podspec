Pod::Spec.new do |s|
s.name         = "EightBase"
s.version      = "0.0.1.4"
s.summary      = "EightBase library for iOS"
s.homepage     = "http://8base.com"
s.authors      = "8base"
s.license      = { :type => 'MIT', :file => 'LICENSE' }
s.platform     = :ios, "10.0"
s.source       = { :git => "https://vvshevtsov@github.com/8base/ios-sdk.git", :tag => "#{s.version}" }
s.source_files = "Sources/**/*"

s.requires_arc = true

s.swift_version = '4.0'

s.ios.dependency     'Auth0'
s.ios.dependency     'Apollo'
s.ios.dependency     'ApolloAlamofire'

s.ios.deployment_target = '10.0'

end
