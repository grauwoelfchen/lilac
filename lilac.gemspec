lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "lilac/version"

Gem::Specification.new do |spec|
  spec.name          = "lilac"
  spec.version       = Lilac::VERSION
  spec.authors       = ["Yasuhiro Asaka"]
  spec.email         = ["grauwoelfchen@gmail.com"]
  spec.summary       = %q{Luxury Indented List Another Converter}
  spec.description   = %q{The Converter for various list text}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
