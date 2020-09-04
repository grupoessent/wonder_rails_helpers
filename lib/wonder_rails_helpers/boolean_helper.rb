module WonderRailsHelpers
  module BooleanHelper
    # Retorna uma string com valor booleano 'yes' ou 'no' para um valor dado.
    # Valores são <b>case insensitive</b>.
    # Valores aceitos são:
    #   boolean (true);
    #   strings (yes, y, s, t, v, verdadeiro, sim, true);
    #   numbers (1);
    #
    # ==== Examples
    #
    #   toyesno(true)
    #   # => "yes"
    #
    #   toyesno('y') # locale pt-BR
    #   # => "yes"
    #
    #   toyesno # locale pt-BR
    #   # => "no"
    def toyesno(value = nil)
      %w[T V Y 1 YES TRUE VERDADEIRO S SIM].include?(value.to_s.upcase) ? 'yes' : 'no'
    end
  end
end
