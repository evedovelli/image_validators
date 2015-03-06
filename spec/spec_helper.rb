require 'active_model'
require 'active_record'
require 'image_validators'
require 'image_validators/dimensions_validator'
require 'paperclip'
require 'mocha/api'

ROOT = Pathname(File.expand_path(File.join(File.dirname(__FILE__), '..')))

RSpec.configure do |config|
  config.mock_with :mocha
  Paperclip.options[:log] = false
end

