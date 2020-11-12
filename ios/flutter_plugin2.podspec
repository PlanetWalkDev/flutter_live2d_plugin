#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_plugin2.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_plugin2'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin.'
  s.description      = <<-DESC
A new Flutter plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = ['Classes/**/*','PPLive2D/Live2D/include/**/*','PPLive2D/Live2D/framework/**/*','PPLive2D/Tools/**/*']
  s.public_header_files = 'Classes/**/*.h'
  s.vendored_library = 'PPLive2D/Live2D/lib/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'
  s.libraries = 'c++'
  s.frameworks = 'GLKit', 'OpenGLES','CoreMotion','AVFoundation'
  s.xcconfig = {
    'GCC_PREPROCESSOR_DEFINITIONS' => 'L2D_TARGET_IPHONE',
    'ENABLE_BITCODE' => 'NO'
  }
  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
end
