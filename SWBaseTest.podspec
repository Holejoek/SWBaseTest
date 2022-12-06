Pod::Spec.new do |s|
  s.name = 'SWBaseTest'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'Test framework'
  s.homepage = 'https://github.com/denandreychuk/PMUserPrinter'
  s.authors = { 'Ivan Timinskiy' => 'Eggman12363@gmail.com' }
  
  s.source = { :git => 'https://github.com/denandreychuk/PMUserPrinter.git', :tag => s.version.to_s }
  s.source_files = 'Sources/*.swift'
  s.swift_version = '5.0'
  s.platform = :ios, '13.0'


end