[![Gem Version](https://badge.fury.io/rb/jive_add_ons.svg)](http://badge.fury.io/rb/jive_add_ons)
[![Build Status](https://travis-ci.org/butchmarshall/jive_add_ons.svg?branch=master)](https://travis-ci.org/butchmarshall/jive_add_ons)

# JiveAddOns

JiveAddOns is a mountable engine for Rails that enables [Jive](https://www.jivesoftware.com) [Add-On](https://community.jivesoftware.com/docs/DOC-99941) functionality.

Release Notes
============

**0.0.6**
 - Extracted `JiveAddOns::AddOn` ActiveRecord functionality into a the separate gem [Jive::AddOn](https://github.com/butchmarshall/ruby-jive-add_on) and now uses interface Jive::AddOn::Model

**0.0.4**
 - Whitelist/blacklist functionality for add-on names
 - Removed jive_os_apps integration - people should be able to make this choice themselves

**0.0.2**
 - Dummy app now registers/unregisters with [Jive Sandbox](https://sandbox.jiveon.com)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jive_add_ons'
```

then run

```ruby
bundle exec rake db:migrate
```

## Usage

In your routes.rb file, mount the rails engine to enable add-on support.

```ruby
Rails.application.routes.draw do
	mount JiveAddOns::Engine => "/special_path_for_api"
end
```

See /spec/dummy/extension_src for the example add-on extension that is uploaded.  You'll need to change the endpoints!

For whitelisting and blacklisting specific

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/butchmarshall/jive_add_ons.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).