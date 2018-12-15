# Uncomment this line to define a global platform for your project
 platform :ios, '10.0'

def testing_pods
    pod 'Quick'
    pod 'Nimble'
    pod 'RxSwift'
    pod 'RxBlocking'
    pod 'RxTest'
    pod 'Cuckoo'
end

target 'hindsight' do
# Comment this line if you're not using Swift and don't want to use dynamic frameworks
   use_frameworks!

  # Pods for hindsight
  pod 'SwiftGen'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Moya'
  pod 'Moya/RxSwift'
  pod 'Swinject'
  pod 'SnapKit'
  pod 'SwiftLint'
  pod 'RealmSwift'
  
   target 'hindsightTests' do
    inherit!  :search_paths
    testing_pods
  end

   target 'hindsightUITests' do
    inherit! :search_paths
    # Pods for testing
  end
end
