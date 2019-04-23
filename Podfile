
platform :ios, '12.0'
plugin 'cocoapods-binary'
use_frameworks!
all_binary!


# Utility
def utility
    pod 'SwiftyBeaver', :configurations => ['Debug']
    pod 'Weakify', :configurations => ['Debug']
end

# UI
def ui
    pod 'AloeStackView', :configurations => ['Debug']
    pod 'TinyConstraints', :configurations => ['Debug']
end

# RX 
def rx
    pod 'RxSwift', :configurations => ['Debug']
    pod 'RxAtomic', :configurations => ['Debug']
    pod 'RxCocoa', :configurations => ['Debug']
    pod 'RxBiBinding', :configurations => ['Debug']
    pod 'RxSwiftExt', :configurations => ['Debug']
    pod 'RxViewController', :configurations => ['Debug']
end

target 'FlowCoordinator' do
    utility
    ui
    rx
end

target 'FlowCoordinatorTests' do
    rx
end
