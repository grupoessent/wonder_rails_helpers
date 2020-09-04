require 'wonder_rails_helpers/version'
require 'wonder_rails_helpers/engine'
require 'wonder_rails_helpers/configuration'

module WonderRailsHelpers
  class << self
    attr_reader :provider

    def configure
      @configuration = WonderRailsHelpers::Configuration.new

      yield @configuration

      @configuration.require_modules!

      return unless defined?(ActionView)

      WonderRailsHelpers.constants.each do |sub_module|
        module_name = "WonderRailsHelpers::#{sub_module}".constantize

        next unless module_name.is_a?(Module) && !module_name.is_a?(Class)

        ActionView::Base.send :include, module_name
      end
    end
  end
end
