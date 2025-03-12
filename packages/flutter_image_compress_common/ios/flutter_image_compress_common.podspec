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
  s.platform = :ios, '12.0'

  s.source_files = 'flutter_image_compress_common/Sources/flutter_image_compress_common/**/*'
  s.swift_version = '5.0'

  s.dependency 'Flutter'
  s.dependency 'Mantle'
  s.dependency 'SDWebImage'
  s.dependency 'SDWebImageWebPCoder'
  s.dependency 'SYPictureMetadata'
end
