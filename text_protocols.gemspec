# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'text_protocols/version'

Gem::Specification.new do |spec|
  spec.name          = "text_protocols"
  spec.version       = TextProtocols::VERSION
  spec.authors       = ["Jorge Luis Pérez"]
  spec.email         = ["jolisper@gmail.com"]
  spec.description   = %q{DSL to create text protocols}
  spec.summary       = %q{DSL to create text protocols and start a server that responds to the commands (telnet style)}
  spec.homepage      = "https://github.com/jolisper/text_protocols"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
