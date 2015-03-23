# AttrSetting

[![Build Status](https://travis-ci.org/merhard/attr_setting.svg?branch=master)](https://travis-ci.org/merhard/attr_setting)

## Why use `AttrSetting`?

Imagine having a class definition similar to this one:

```ruby
class Configuration
  attr_accessor :send_email

  def initialize
    @send_email = true
  end

  def send_email?
    send_email
  end
end
```

The class defines a `Configuration` object that contains a setting for whether the application should send an email.
The `send_email` setting defaults to true.

There is a lot of repitition of "send_email" in this class definition. Any changes to this setting, be it a rename or deletion, requires changing multiple lines of code spread out over the class definition.

`AttrSetting` DRYs up this definition in a clear, concise way:

```ruby
class Configuration
  attr_setting :send_email, true
end
```

No more repitition. Only one line of code to change.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'attr_setting'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install attr_setting

## Usage

`attr_setting` provides enhanced functionality to Ruby's `attr_accessor`.

To use, require the library and extend the module:
```ruby
require 'attr_setting'

class Config
  extend AttrSetting
end
```

A monkeypatch is available to auto-extend `AttrSetting` for use in all Module and Class definitions:
```ruby
require 'attr_setting/core_ext/module'
```

`attr_setting` adds default values to `attr_accessor` in the form of a second argument or block:
```ruby
require 'attr_setting'

class Config
  extend AttrSetting

  attr_setting :foo, 'Second argument'
  attr_setting(:bar) { 'Block' }
end

config = Config.new
config.foo          # => 'Second argument'
config.bar          # => 'Block'
```

The block is evaluated in the context of the object:
```ruby
require 'attr_setting'

class Config
  extend AttrSetting

  attr_setting :foo, 'Foo value'
  attr_setting(:bar) { foo }
end

config = Config.new
config.foo          # => 'Foo value'
config.bar          # => 'Foo value'
```

The block is lazily evaluated:
```ruby
require 'attr_setting'

class Config
  extend AttrSetting

  attr_setting :foo
  attr_setting(:bar) { foo }
end

config = Config.new
config.foo = 'New value'
config.bar               # => 'New value'
```

`attr_setting` also adds a couple other features besides default values for `attr_accessor`.

It adds a predicate method:
```ruby
require 'attr_setting'

class Config
  extend AttrSetting

  attr_setting :foo
end

config = Config.new
config.foo?             # => false
config.foo = :something
config.foo?             # => true
```

It adds a bang method to reset values to their defaults:
```ruby
require 'attr_setting'

class Config
  extend AttrSetting

  attr_setting :foo, 'Default'
end

config = Config.new
config.foo               # => 'Default'
config.foo = 'New value'
config.foo               # => 'New value'
config.foo!
config.foo               # => 'Default'
```

It treats getters with an argument as setters:
```ruby
require 'attr_setting'

class Config
  extend AttrSetting

  attr_setting :foo
end

config = Config.new
config.foo('New value')
config.foo              # => 'New value'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/attr_setting/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
