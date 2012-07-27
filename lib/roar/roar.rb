module Roar
  vendor = File.expand_path('../../../vendor', __FILE__)
  ICONS  = File.expand_path('../icons', __FILE__)
  TERMINAL_NOTIFICATION_BIN = File.join(vendor, 'terminal-notifier_v1.0/terminal-notifier.app/Contents/MacOS/terminal-notifier')
  NOTIFICATION_ICON = File.join(vendor, 'terminal-notifier_v1.0/terminal-notifier.app/Contents/Resources/Terminal.icns')

  class << self
    attr_accessor :use, :app_bundle_identifier, :app_name
    alias_method :use?, :use

    def usable?
      @usable ||= `uname`.strip == 'Darwin' && `sw_vers -productVersion`.strip >= '10.8'
    end

    def change_occured(status)
      notify('Kicker: Executing', status.command)
    end

    def result(status)
      status.success? ? succeeded(status) : failed(status)
    end

    [:success, :error, :warning, :pending, :info, :broken].each do |type|
      define_method type do |message, options={}|
        icon = options.fetch :icon, File.join(ICONS, "#{type}.icns")
        title = "#{app_name}: #{type.capitalize}"
        notify title, message, icon
      end
    end

    def notify(title, message, icon=nil)
      icon = File.join(ICONS, 'info.icns') unless icon && File.exists?(icon)
      link_icon icon
      `'#{TERMINAL_NOTIFICATION_BIN}' #{Dir.pwd} '#{title}' '#{message}' '#{app_bundle_identifier}'`
    end

    def app_name
      @app_name || "Roar"
    end

    private

    def link_icon(icon)
      `ln -sf #{icon} #{NOTIFICATION_ICON}` if File.exists?(icon) && NOTIFICATION_ICON != icon
    end
  end
end

Roar.use = true
Roar.app_bundle_identifier = 'com.googlecode.iterm2'
