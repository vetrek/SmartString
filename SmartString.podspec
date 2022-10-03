Pod::Spec.new do |s|
  s.name      = 'SmartString'
  s.version   = '1.0.9'
  s.summary   = 'Lightweight String styling library'
  s.homepage  = 'https://github.com/vetrek/SmartString'
  s.license   = { :type => 'MIT', :file => 'LICENSE' }
  s.author   = { 'Valerio Sebastianelli' => 'valerio.alsebas@gmail.com' } 
  s.source    = { :git => 'https://github.com/vetrek/SmartString.git', :tag => s.version }
  s.ios.deployment_target = '10.0'
  s.swift_versions = ['5.1', '5.2', '5.3']
  s.source_files = 'Sources/**/*.swift'
end
