module WonderRailsHelpers
  module ErrorHelper
    def error_tag(model, attribute)
      return unless model.errors.key? attribute

      content_tag :div, model.errors[attribute].join(', '), class: 'error_message'
    end
  end
end
