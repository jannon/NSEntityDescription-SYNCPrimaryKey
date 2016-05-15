Pod::Spec.new do |s|
  s.name             = "NSEntityDescription-SYNCPrimaryKey"
  s.summary          = "Support for primary keys in Core Data"
  s.version          = "1.1.1"
  s.homepage         = "https://github.com/hyperoslo/NSEntityDescription-SYNCPrimaryKey"
  s.license          = 'MIT'
  s.author           = { "Hyper Interaktiv AS" => "ios@hyper.no" }
  s.source           = { :git => "https://github.com/hyperoslo/NSEntityDescription-SYNCPrimaryKey.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/hyperoslo'
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'
  s.requires_arc = true
  s.source_files = 'Source/**/*'
  s.frameworks = 'CoreData'
  s.dependency 'NSString-HYPNetworking', '~> 1.0.0'
end
