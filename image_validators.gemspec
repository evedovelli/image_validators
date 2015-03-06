# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'image_validators/version'

Gem::Specification.new do |spec|
  spec.name          = "image_validators"
  spec.version       = ImageValidators::VERSION
  spec.authors       = ["Estevan Vedovelli"]
  spec.email         = ["evedovelli@gmail.com"]
  spec.description   = %q{A set of validators for image files. Currently it includes validators for image dimensions. See details in http://github.com/evedovelli/image_validators}
  spec.summary       = %q{A set of validators for image files}
  spec.homepage      = "http://github.com/evedovelli/image_validators"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activemodel"
  spec.add_dependency "i18n"
  spec.add_dependency "paperclip"

  spec.add_development_dependency "activerecord", ">= 3.0.0"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "mocha"
end
