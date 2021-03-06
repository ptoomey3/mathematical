# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mathematical/version'

Gem::Specification.new do |spec|
  spec.name          = "mathematical"
  spec.version       = Mathematical::VERSION
  spec.authors       = ["Garen Torikian"]
  spec.email         = ["gjtorikian@gmail.com"]
  spec.summary       = %q{Quickly convert math equations into beautiful SVGs.}
  spec.description   = %q{A very fast way to turn itex math equations into beautifully rendered SVGs, to embed on the web. This library is a general purpose wrapper to GNOME's Lasem. }
  spec.homepage      = "https://github.com/gjtorikian/mathematical"
  spec.license       = "MIT"

  spec.files         = %w(LICENSE.txt README.md Rakefile mathematical.gemspec)
  spec.files        += Dir.glob("lib/**/*.rb")
  spec.files        += Dir.glob("ext/**/*.{c,h}")
  spec.files        += Dir.glob("ext/**/extconf.rb")
  spec.test_files    = Dir.glob("test/**/*")
  spec.require_paths = ["lib", "ext"]
  spec.extensions    = ["ext/mathematical/extconf.rb"]

  spec.add_development_dependency "rake-compiler", "~> 0.9"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "mocha", "~> 1.0"
  spec.add_development_dependency "math-to-itex", "~> 0.1"
end
