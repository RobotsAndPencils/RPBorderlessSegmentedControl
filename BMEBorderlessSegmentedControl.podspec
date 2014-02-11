Pod::Spec.new do |s|
  s.name             = "BMEBorderlessSegmentedControl"
  s.version          = "0.1.0"
  s.summary          = "A replica of Xcode 5's toolbar segmented controls"
  s.homepage         = "https://www.github.com/interestateone/BMEBorderlessSegmentedControl"
  s.screenshots      = "http://f.cl.ly/items/371q3735140m3c1j1F0t/Screenshot%202014-02-10%2023.09.51.png"
  s.license          = 'MIT'
  s.author           = { "Brandon Evans" => "brandon@brandonevans.ca" }
  s.source           = { :git => "https://github.com/interstateone/BMEBorderlessSegmentedControl.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/interstateone'

  s.platform     = :osx, '10.9'
  s.osx.deployment_target = '10.9'
  s.requires_arc = true

  s.source_files = 'Classes', 'Categories'
end
