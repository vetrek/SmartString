Pod::Spec.new do |s|
  s.name      = 'SmartString'
  s.version   = '0.0.2'
  s.summary   = 'Lightweight String styling library'
  s.homepage  = 'https://github.com/vetrek/SmartString'
  s.license   = { :type => 'MIT', :file => 'LICENSE' }
  s.author   = { 'Valerio Sebastianelli' => 'valerio.alsebas@gmail.com' } 
  s.source    = { :git => 'https://github.com/vetrek/SmartString.git', :tag => s.version }
  s.ios.deployment_target = '12.0'
  s.osx.deployment_target = '10.15'
  s.swift_versions = ['5.1', '5.2', '5.3']
  s.source_files = 'Source/**/*.swift'
end
