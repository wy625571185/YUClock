# Uncomment the next line to define a global platform for your project

target 'YUClock' do
  # Comment the next line if you don't want to use dynamic frameworks
  platform :ios, '8.0'
  use_frameworks!

  # Pods for YUClock
  pod 'tingyunApp'
  pod 'Bugly'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 8.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '8.0'
      end
    end
  end
end
