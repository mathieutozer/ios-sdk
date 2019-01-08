Pod::Spec.new do |s|
s.name         = "EightBase"
s.version      = "0.0.1.2"
s.summary      = "EightBase library for iOS"
s.homepage     = "http://8base.com"
s.authors      = { 'Vladyslav Vshevtsov' => 'elpastor.dev@gmail.com' }
s.license      = { :type => 'MIT', :file => 'LICENSE' }
s.platform     = :ios, "10.0"
s.source       = { :git => "https://vvshevtsov@github.com/vvshevtsov/8base.git", :tag => "#{s.version}" }
s.source_files = "Sources/**/*"

s.requires_arc = true

s.swift_version = '4.0'

s.dependency    = 'Auth0'
s.dependency    = 'Apollo'

s.ios.deployment_target = '10.0'

end
