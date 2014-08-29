# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chennai_roads/version'

Gem::Specification.new do |spec|
  spec.name          = "chennai_roads"
  spec.version       = ChennaiRoads::VERSION
  spec.authors       = ["Nithin Krishna"]
  spec.email         = ["nithin@codebrahma.com"]
  spec.summary       = %q{A rails like web framework}
  spec.description   = %q{A rack based web framework}
  spec.homepage      = "http://nithinkrishan.github.io"
  spec.license       = "MIT"
  spec.files         = Dir['lib/   *.rb']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency "rack"
  spec.add_runtime_dependency "erubis"

end
