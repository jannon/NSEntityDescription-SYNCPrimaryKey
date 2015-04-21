Pod::Spec.new do |s|
  s.name             = "NSEntityDescription-SYNCPrimaryKey"
  s.summary          = "Support for primary keys in Core Data"
  s.version          = "0.1.0"
  s.homepage         = "https://github.com/hyperoslo/NSEntityDescription-SYNCPrimaryKey"
  s.license          = 'MIT'
  s.author           = { "Hyper Interaktiv AS" => "ios@hyper.no" }
  s.source           = { :git => "https://github.com/hyperoslo/NSEntityDescription-SYNCPrimaryKey.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/hyperoslo'
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'Source/**/*'
  s.frameworks = 'CoreData'
end