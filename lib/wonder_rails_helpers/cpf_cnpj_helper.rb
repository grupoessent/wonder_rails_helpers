require 'cpf_cnpj'

module WonderRailsHelpers
  module CpfCnpjHelper
    # Retorna um número de CNPJ formatado no padrão '00.000.000/0000-00'.
    #
    # ==== Examples
    #
    #  cnpj_formatado(99999999000199)
    #  # => "99.999.999/0001-99"
    def cnpj_formatado(cnpj)
      CNPJ.new(ajusta_zeros_esquerda(cnpj, :cnpj)).formatted
    end

    # Retorna um número de CPF formatado no padrão '000.000.000-00'.
    #
    # ==== Examples
    #
    #  cpf_formatado(12345678910)
    #  # => "123.456.789-10"
    def cpf_formatado(cpf)
      CPF.new(ajusta_zeros_esquerda(cpf, :cpf)).formatted
    end

    private

    def ajusta_zeros_esquerda(num, tipo)
      num.to_s
         .split(/[^\d]+/i)
         .join
         .rjust(tipo == :cnpj ? 14 : 11, '0')
    end
  end
end
