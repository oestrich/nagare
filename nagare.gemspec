lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name        = "nagare"
  s.version     = "1.3.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Eric Oestrich"]
  s.email       = ["eric@oestrich.org"]
  s.summary     = "Serialize your ruby objects"
  s.description = "Serialize your ruby objects"
  s.homepage    = "http://github.com/oestrich/nagare"
  s.license     = "MIT"

  s.required_rubygems_version = ">= 1.3.6"

  s.add_runtime_dependency "activesupport", ">= 4.0"

  s.add_development_dependency "rspec", "~> 3.0"

  s.files        = Dir.glob("lib/**/*")
  s.require_path = 'lib'
end
