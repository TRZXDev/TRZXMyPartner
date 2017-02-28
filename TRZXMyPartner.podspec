
Pod::Spec.new do |s|

  s.name         = "TRZXMyPartner"
  s.version      = "0.0.1"
  s.summary      = "TRZXMyPartner 我的伙伴组件"

  s.homepage     = "https://github.com/TRZXDev/TRZXMyPartner.git"
 
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "Rhino" => "502244672@qq.com" }

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/TRZXDev/TRZXMyPartner.git", :tag => s.version.to_s }

  s.source_files = "TRZXMyPartner/TRZXMyPartner/*.{h,m}"
  s.resources    = "TRZXMyPartner/TRZXMyPartner/*.{xib,png}"  

  s.dependency 'TRZXNetwork'  
  s.dependency 'TRZXKit'
  s.dependency 'MJExtension'
  s.dependency 'CTMediator'
  s.dependency 'MJRefresh'
  s.dependency 'SDWebImage'
  s.dependency 'TRZXDIYRefresh'
  s.dependency 'TRZXDVSwitch'

  s.requires_arc = true

end