require 'date'
require 'time'

module WonderRailsHelpers
  module DateTimeHelper
    # Retorna a data formatada como "DD/MM/YYYY".
    # Pode ser invocado como ldate.
    #
    # ==== Examples
    #
    #   human_date(Date.today) # hoje é 07/04/2017
    #   # => 07/04/2017
    def human_date(date, pattern = '%d/%m/%Y')
      sanitize_datetime(date).strftime(pattern) if date
    end

    alias ldate human_date

    # Retorna a data e hora formatada como "DD/MM/YYYY HH:MM".
    # Pode ser invocado como ltime.
    #
    # ==== Examples
    #
    #   human_datetime(DateTime.now) # agora é 07/04/2017 10:30
    #   # => 07/04/2017 10:30
    def human_datetime(time, pattern = '%d/%m/%Y %H:%M')
      sanitize_datetime(time).strftime(pattern) if time
    end

    alias ltime human_datetime

    private

    def sanitize_datetime(value)
      value.is_a?(String) ? DateTime.parse(value) : value
    end
  end
end
