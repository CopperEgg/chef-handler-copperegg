# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name          = 'chef-handler-copperegg'
  s.version       ='0.1.4'
  s.default_executable = 'chef-handler-copperegg'

  s.platform      = Gem::Platform::RUBY
  s.authors       = ["scott johnson"]
  s.email         = ["sjohnson@copperegg.com"]
  s.description   = %q{This Handler will report the metrics for a chef-client run to Uptime Cloud Monitor.}
  s.summary       = %q{Chef Handler for Uptime Cloud Monitor metrics}
  s.license       = 'MIT'

  s.require_paths = ["lib"]
  s.files         = Dir["#{File.dirname(__FILE__)}/**/*"]
end
