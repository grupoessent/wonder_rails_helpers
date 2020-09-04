module WonderRailsHelpers
  class Configuration
    def initialize
      @modules = []
    end

    def require_modules=(*args)
      @modules += args.flatten.collect(&:to_sym)
      @modules.uniq!
    end

    def require_modules!
      return if @modules.empty?

      @modules.each do |mod|
        require_relative mod.to_s.downcase
      end
    end
  end
end
