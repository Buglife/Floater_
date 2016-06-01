Pod::Spec.new do |s|
  s.name             = 'Floater💩'
  s.version          = '0.1.0'
  s.summary          = 'Leave a trail of fingerprints on your screen for app demos.'
  s.homepage         = 'https://github.com/Buglife/Floater_'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dave Schukin' => 'dave@buglife.com' }
  s.source           = { :git => 'https://github.com/Buglife/Floater_.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/BuglifeApp'
  s.ios.deployment_target = '8.0'

  s.source_files = 'Floater💩/Classes/Shared/**/*'

  s.subspec 'Shared' do |sp|
    sp.source_files = 'Floater💩/Classes/Shared/**/*'
    sp.dependency 'HSTestingBackchannel', '1.2.1'
  end

  s.subspec 'AppStuff' do |sp|
    sp.source_files = 'Floater💩/Classes/AppStuff/**/*'
    sp.dependency 'Floater💩/Shared'
    s.frameworks = 'CoreImage'
  end

  s.subspec 'UITestStuff' do |sp|
    sp.source_files = 'Floater💩/Classes/UITestStuff/**/*'
    sp.dependency 'Floater💩/Shared'
    sp.frameworks = 'XCTest'
    s.ios.deployment_target = '9.0'
  end
end
