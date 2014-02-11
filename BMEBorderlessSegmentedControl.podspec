Pod::Spec.new do |s|
  s.name             = "BMEBorderlessSegmentedControl"
  s.version          = "0.1.0"
  s.summary          = "A short description of BMEBorderlessSegmentedControl."
  s.description      = <<-DESC
                       An optional longer description of BMEBorderlessSegmentedControl

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "http://EXAMPLE/NAME"
  s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Brandon Evans" => "brandon@brandonevans.ca" }
  s.source           = { :git => "http://EXAMPLE/NAME.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/NAME'

  s.platform     = :osx, '10.9'
  s.osx.deployment_target = '10.9'
  s.requires_arc = true

  s.source_files = 'Classes'
  s.resources = 'Assets'
end
