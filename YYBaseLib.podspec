Pod::Spec.new do |spec|
  spec.name         = 'YYBaseLib'
  spec.version      = '1.0.4'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/chuanxiaoshi/YYBaseLib'
  spec.authors      = { 'chuanxiaoshi' => '13466932727@163.com' }
  spec.summary      = 'ARC and GCD Compatible Reachability Class for iOS and OS X.'
  spec.source       = { :git => 'https://github.com/chuanxiaoshi/YYBaseLib.git', :tag =>'1.0.4'  }
  spec.source_files = 'YYBaseLib/**/*.{h,m}'
  spec.resource     = 'YYBaseLib/YYBaseLib.bundle'
  spec.platform     = :ios, '8.0'
  spec.framework    = 'SystemConfiguration'
 spec.dependency 'AFNetworking', '~> 2.0'
  spec.dependency 'Masonry'
 spec.dependency 'YYModel'
 spec.dependency 'MJRefresh'
 spec.dependency 'SDWebImage'
end