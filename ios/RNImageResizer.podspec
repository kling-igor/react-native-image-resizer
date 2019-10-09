
Pod::Spec.new do |s|
  s.name         = "RNImageResizer"
  s.version      = "1.0.0"
  s.summary      = "RNImageResizer"
  s.description  = <<-DESC
                  RNImageResizer
                   DESC
  s.homepage     = ""
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "author@domain.cn" }
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/kling-igor/react-native-image-resizer.git", :tag => "master" }
  s.source_files  = "RNImageResizer/**/*.{h,m}"
  s.requires_arc = true


  s.dependency "React"
  #s.dependency "others"

end

  