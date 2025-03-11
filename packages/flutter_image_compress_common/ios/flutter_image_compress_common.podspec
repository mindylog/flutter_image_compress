Pod::Spec.new do |s|
  s.name             = 'flutter_image_compress_common'
  s.version          = '1.0.0'
  s.summary          = 'Compress image with native Swift with faster speed.'
  s.description      = <<-DESC
Compress image with native Swift with faster speed.
                       DESC
  s.homepage         = 'http://github.com/fluttercandies/flutter_image_compress'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'fluttercandies' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.ios.deployment_target = '12.0'

  s.source_files = 'Sources/flutter_image_compress_common/**/*'
  s.public_header_files = 'Sources/flutter_image_compress_common/**/*.h'
  s.swift_version = '5.0'

  s.dependency 'Flutter'
  s.dependency 'Mantle'
  s.dependency 'SDWebImage'
  s.dependency 'SDWebImageWebPCoder'
  s.dependency 'SYPictureMetadata'
end
