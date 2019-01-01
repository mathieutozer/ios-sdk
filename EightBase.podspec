Pod::Spec.new do |s|
s.name         = "EightBase"
s.version      = "0.0.1"
s.summary      = "EightBase library"
s.homepage     = "http://8base.com"
s.authors      = "8base"
s.license      = { :type => 'MIT', :file => 'LICENSE' }
s.platform     = :ios, "10.0"
s.source       = { :git => "http://github.com/vvshevtsov/8base.git", :tag => "#{s.version}" }
s.source_files = "Sources/**/*"

s.requires_arc = true

s.swift_version = '4.0'

end
