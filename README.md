# Image Validators

[![Gem Version](https://badge.fury.io/rb/image_validators.svg)](http://badge.fury.io/rb/image_validators)
[![Build Status](https://travis-ci.org/evedovelli/image_validators.svg?branch=v1.0.1)](https://travis-ci.org/evedovelli/image_validators)
[![Code Climate](https://codeclimate.com/github/evedovelli/image_validators/badges/gpa.svg)](https://codeclimate.com/github/evedovelli/image_validators)


A set of validators for image files.


## Installation

Add this line to your application's Gemfile:

    gem 'image_validators'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install image_validators


## Usage

In your model you have a image file attribute attached by using [Paperclip](https://github.com/thoughtbot/paperclip):

    class User < ActiveRecord::Base
      has_attached_file :photo, :styles => {:medium => "620x620>", :thumb => "200x200#"}

### Validation of image dimensions

To validate the width and height of the image are greater or equal than 620x620, add to your model:

    validates :image, :dimensions => {:greater_than_or_equal_to => {width: 620, height: 620}}

You can validate your image dimensions whith these operations: `:less_than`, `:less_than_or_equal_to`, `:greater_than`, `:greater_than_or_equal_to`, or `:equal_to`.

Optionally you can also specify an error message:

    validates :image, :dimensions => {:equal_to => {width: 620}, :message => "Invalid image dimensions"}


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
