Pod::Spec.new do |s|
  s.name               = "SafeDefaultsKit"
  s.version            = "1.0.3"
  s.license            = { :type => "MIT", :file => "LICENSE" }
  s.summary            = "Pure-Swift library for safe access to UserDefaults"
  s.homepage           = "https://github.com/jrsaruo/SafeDefaultsKit"
  s.author             = { "Yusaku Nishi" => "jrsaruo@gmail.com" }
  s.social_media_url   = "http://twitter.com/jrsaruo"

  s.platform           = :ios, "10.0"

  s.source             = { :git => "https://github.com/jrsaruo/SafeDefaultsKit.git", :tag => "v#{s.version}" }
  s.source_files       = "SafeDefaultsKit/**/*.swift"

  s.requires_arc       = true
end
