# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'
use_frameworks!

target 'EightBase' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks

  # Pods for EightBase
  pod 'Auth0'
  pod 'Apollo'
  pod 'ApolloAlamofire'

  target 'EightBaseTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'Example' do
#    pod 'EightBase'
    pod 'Auth0'
##    pod 'Apollo'
    pod 'ApolloAlamofire'
    pod 'JGProgressHUD'
end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
        end
    end
end
