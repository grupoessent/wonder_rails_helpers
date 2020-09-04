module WonderRailsHelpers
  module AppHelper
    # Retorna uma string com a versão do aplicativo fornecida
    # pelo `.application-version` na pasta root do projeto.
    #
    # ==== Examples
    #
    #   application_version # arquivo contém: 1.0.0.rc2
    #   # => "1.0.0.rc2"
    def application_version
      File.read("#{::Rails.root}/.application-version").strip
    end
  end
end
