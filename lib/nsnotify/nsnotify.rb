module Nsnotify
  vendor = File.expand_path('../../../vendor', __FILE__)
  ICONS  = File.expand_path('../icons', __FILE__)
  TERMINAL_NOTIFICATION_BIN = File.join(vendor, 'terminal-notifier_v1.0/terminal-notifier.app/Contents/MacOS/terminal-notifier')

  class << self
    attr_accessor :use, :app_bundle_identifier, :app_name
    alias_method :use?, :use

    # Determines whether you are running OS X 10.8 or later, which
    # is the minimum required for the Notification Center.
    #
    def usable?
      @usable ||= `uname`.strip == 'Darwin' && `sw_vers -productVersion`.strip >= '10.8'
    end

    # Convenience methods for common message types (success, warning,
    # error, pending, info, broken).
    #
    # ==== Parameters
    #
    # message<String>:: the message to show
    #
    # ==== Examples
    #
    #    Nsnotify.success "That went well"
    #
    #    Nsnotify.error "That went not so well!"
    #
    #    Nsnotify.pending "This test still needs some work."
    #
    [:success, :error, :warning, :pending, :info, :broken].each do |type|
      define_method type do |message|
        title = "#{app_name}: #{type.capitalize}"
        notify title, message
      end
    end

    # Calls the notification service.
    #
    # ==== Parameters
    #
    # title<String>:: the title of the notification
    # message<String>:: the actual message
    #
    # ==== Example
    #
    #   Nsnotify.notify "Testing!", "Can you see me?!"
    #
    def notify(title, message)
      throw "This gem needs OSX 10.8 Mountain Lion to work!" if not usable?
      `'#{TERMINAL_NOTIFICATION_BIN}' #{Dir.pwd} '#{title}' '#{message}' '#{app_bundle_identifier}'`
    end

    def app_name
      @app_name || "Nsnotify"
    end
  end
end

Nsnotify.use = true
Nsnotify.app_bundle_identifier = 'com.apple.Terminal'
