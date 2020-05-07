# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'EcommerceApp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for EcommerceApp
  
  pod 'Alamofire', '~> 4.3'


  pod "AlamofireRSSParser"
  pod 'ObjectMapper', '~> 2.2'

  pod 'FacebookCore'
  pod 'FacebookLogin'
  pod 'FacebookShare'

  pod 'Fabric'
  pod 'TwitterKit'
  pod 'TwitterCore'

  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'ImageSlideshow', '~> 1.0.0-beta.1'
  pod "ImageSlideshow/Alamofire"
  pod "ImageSlideshow/AFURL"
  pod "ImageSlideshow/SDWebImage"
  pod "ImageSlideshow/Kingfisher"
  
  pod 'Stripe'

  pod 'Material', '~> 2.0'
  pod 'MaterialComponents/Tabs'
  
  pod 'Kingfisher'
  pod 'SwiftyJSON', '3.1.4'
  pod 'GoogleMaps', '2.4.0'
end


post_install do | installer |
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3'
    end
  end
end
