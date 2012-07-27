# nsnotify

Uses the built-in OS X Mountain Lion Notification Center to display messages.
It uses a nice app by [Eloy Durán](https://github.com/alloy/terminal-notifier)
that gives you command line access to the service.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nsnotify'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nsnotify

## Usage

```ruby
require 'nsnotify'

# Use the notify method
Nsnotify.notify "Testing!", "Can you see me?!"

# Or one of the other convenience methods
# (success, error, warning, pending, info, broken)
Nsnotify.success "Yeah if this works!"
Nsnotify.error "Did something go wrong?!?"

# You can set the title to your app's name
# instead of that lame Nsnotify.
Nsnotify.app_name = "MyApp"
Nsnotify.success "Yeah, see me?!"
```

## Todo

1. Integration in Guard/Watchr and stuff.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
