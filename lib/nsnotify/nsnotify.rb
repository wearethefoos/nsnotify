module Nsnotify
  vendor = File.expand_path('../../../vendor', __FILE__)
  ICONS  = File.expand_path('../icons', __FILE__)
  TERMINAL_NOTIFICATION_BIN = File.join(vendor, 'terminal-notifier_v1.0/terminal-notifier.app/Contents/MacOS/terminal-notifier')

  class << self
    attr_accessor :use, :app_bundle_identifier, :app_name
    alias_method :use?, :use

    def usable?
      @usable ||= `uname`.strip == 'Darwin' && `sw_vers -productVersion`.strip >= '10.8'
    end

    def result(status)
      status.success? ? succeeded(status) : failed(status)
    end

    [:success, :error, :warning, :pending, :info, :broken].each do |type|
      define_method type do |message|
        title = "#{app_name}: #{type.capitalize}"
        notify title, message
      end
    end

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
Nsnotify.app_bundle_identifier = 'com.googlecode.iterm2'
