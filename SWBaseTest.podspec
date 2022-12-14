Pod::Spec.new do |s|
  s.name = 'SWBaseTest'
  s.version = '1.0.18'
  s.license = 'MIT'
  s.summary = 'Test framework'
  s.homepage = 'https://github.com/Holejoek/SWBaseTest'
  s.authors = { 'Ivan Timinskiy' => 'Eggman12363@gmail.com' }
  
  s.source = { :git => 'https://github.com/Holejoek/SWBaseTest.git', :tag => s.version.to_s }
  s.source_files = 'Sources/**/*.swift'
  s.swift_version = '5.0'
  s.platform = :ios, '14.0'

  s.dependency 'Moya'
  s.dependency 'SnapKit'
  s.dependency 'KeychainAccess'
  s.dependency 'Kingfisher'
end