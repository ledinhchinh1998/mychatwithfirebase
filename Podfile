# Uncomment the next line to define a global platform for your project
#platform :ios, '9.0'

inhibit_all_warnings!
pod 'Firebase/Analytics'
target 'MyChat' do
  pod 'Firebase/Core', :inhibit_warnings => true
  pod 'Firebase/Database', :inhibit_warnings => true
  pod 'Firebase/Auth', :inhibit_warnings => true
  pod 'Firebase/Storage', :inhibit_warnings => true
  pod 'IQKeyboardManagerSwift'
  use_modular_headers!
  pod 'SVProgressHUD'
  pod 'SDWebImage'
  # Pods for MyChat
  
  target 'MyChatTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MyChatUITests' do
    # Pods for testing
  end

end
