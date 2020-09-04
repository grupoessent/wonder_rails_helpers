module WonderRailsHelpers
  module ModelNameHelper
    # Retorna o nome singular do model traduzido usando i18n.
    #
    # ==== Examples
    #
    #   singular_model_name_for(SpaceshipModel)
    #   # => "Nave Espacial"
    def singular_model_name_for(model)
      model.model_name.human
    end

    # Retorna o nome plural do model traduzido usando i18n.
    #
    # ==== Examples
    #
    #   plural_model_name_for(SpaceshipModel)
    #   # => "Naves Espaciais"
    def plural_model_name_for(model)
      model.model_name.human(count: 2)
    end
  end
end
