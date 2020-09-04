module WonderRailsHelpers
  module BootstrapHelper
    BRAND_CLASSES = %i[primary success info warning default danger].freeze

    # Retorna uma classe de cor do bootstrap aleatória, os valores podem ser: :primary, :success, :info
    # :warning, :danger ou :default. Também pode ser invocado como `boostrap_class_sample`.
    #
    # ==== Examples
    #
    #   bs_class_sample
    #   # => :danger (qualquer classe)
    #   bs_class_sample(except: :danger)
    #   # => :primary (qualquer menos :danger)
    #   bs_class_sample(except: [:danger, :primary])
    #   # => :success (qualquer menos :danger ou :primary)
    def bs_class_sample(options = {})
      sample = BRAND_CLASSES.sample
      exceptions = [options[:except]].flatten

      sample = BRAND_CLASSES.sample while exceptions.include?(sample)

      sample
    end

    alias bootstrap_class_sample bs_class_sample

    # Cria um label span do bootstrap 3 com o valor do texto dado e opções fornecidas.
    # Se você está usando bootstrap 4, deve usar o método `bs_tag`.
    #
    # ==== Examples
    #
    #   bs_label('myLabel', class: :primary)
    #   # => <span class="label label-primary">myLabel</span>
    #   bs_label('myLabel', class: "label-primary")
    #   # => <span class="label label-primary">myLabel</span>
    def bs_label(value, options = {})
      klass = options[:class]

      klass = if BRAND_CLASSES.include? klass.to_sym
                "label label-#{klass}"
              else
                "label #{klass}"
              end

      options[:class] = klass

      content_tag :span, value, options
    end

    # Cria um tag span do bootstrap 4 com o valor do texto dado e opções fornecidas.
    # Se você está usando bootstrap 3, deve usar o método `bs_label`.
    #
    # ==== Examples
    #
    #   bs_tag('myLabel', class: :primary)
    #   # => <span class="tag tag-primary">myLabel</span>
    #   bs_tag('myLabel', class: "tag-primary")
    #   # => <span class="tag tag-primary">myLabel</span>
    def bs_tag(value, options = {})
      klass = options[:class]

      klass = if BRAND_CLASSES.include? klass.to_sym
                "tag tag-#{klass}"
              else
                "tag #{klass}"
              end

      options[:class] = klass

      content_tag :span, value, options
    end

    # Cria um badge span do bootstrap 3 com o valor do texto dado e opções fornecidas.
    #
    # ==== Examples
    #
    #   bs_badge('myBadge', class: :primary)
    #   # => <span class="badge badge-primary">myBadge</span>
    #   bs_badge('myBadge', class: "badge-primary")
    #   # => <span class="badge badge-primary">myBadge</span>
    def bs_badge(value, options = {})
      klass = options[:class]

      klass = if BRAND_CLASSES.include? klass.to_sym
                "badge badge-#{klass}"
              else
                "badge #{klass}"
              end

      options[:class] = klass

      content_tag :span, value, options
    end

    # Cria um breadcrumb do bootstrap com as opções fornecidas.
    #
    # ==== Examples
    #
    #   bs_breadcrumb("1", "2", "3")
    #   # => <ol class="breadcrumb">
    #     <li><a href="#">1</a></li>
    #     <li><a href="#">2</a></li>
    #     <li class="active">3</li>
    #   </ol>
    #
    #   bs_breadcrumb({text: "Dashboard", href: "index.html"}, {text: "Inbox"})
    #   # => <ol class="breadcrumb">
    #     <li><a href="index.html">Dashboard</a></li>
    #     <li class="active"><a href="#">Inbox</a></li>
    #   </ol>
    def bs_breadcrumb(*list)
      content_tag :ol, class: 'breadcrumb' do
        concat(list.each_with_index.map do |element, index|
          path = '#'
          text = element.to_s
          li_class = 'active' if index == list.length - 1

          if element.is_a?(Hash)
            text = element[:text]
            path = (element[:path] || element[:link] || element[:href] || '#')
          end

          content_tag :li, class: li_class do
            content_tag :a, text, href: path
          end
        end.join.html_safe)
      end
    end

    # Cria uma barra de progresso do bootstrap com as opções fornecidas.
    #
    # ==== Examples
    #
    #   bs_progress(50, {class: :primary, active: true, size: :sm, hide_caption: true})
    #   # => <div class="progress progress-striped active progress-bar-sm">
    #     <div class="progress-bar progress-bar-primary" style="width: 50%; " role="progressbar"></div>
    #   </div>
    def bs_progress(value, options = {})
      klass = "progress-bar progress-bar-#{options[:class]}"
      value = value.to_i
      value_f = "#{value}%"
      parent_class = ['progress']
      parent_class << 'progress-striped active' if options[:active]
      parent_class << "progress-bar-#{options[:size]}" if options[:size]

      content_tag(:div, class: parent_class) do
        content_tag(:div, class: klass,
                          style: "width: #{value_f}",
                          role: 'progressbar') do
          if !options[:hide_caption] && %i[xl lg md sm].include?(options[:size])
            content_tag(:strong, value_f)
          end
        end
      end
    end

    # Cria um label do bootstrap 3 com o texto internacionalizado "Sim"/"Não".
    # Também pode ser invocado como `boolean_to_human_label`.
    # Valores são <b>case insensitive</b>.
    # Valores aceitos são:
    #   boolean (true);
    #   strings (yes, y, s, t, v, verdadeiro, sim, true);
    #   numbers (1);
    #
    # ==== Examples
    #
    #   bs_yesno_label(true) # locale pt-BR
    #   # => <span class="label label-success">Sim</span>
    #
    #   bs_yesno_label('y') # locale pt-BR
    #   # => <span class="label label-success">Sim</span>
    #
    #   bs_yesno_label(false, no_class: 'very-red') # locale pt-BR
    #   # => <span class="label very-red">Não</span>
    def bs_yesno_label(value, options = {})
      value = toyesno(value)

      bs_label I18n.t(value), class: value == 'yes' ? options[:yes_class] || :success : options[:no_class] || :danger
    end

    alias boolean_to_human_label bs_yesno_label

    # Retorna um hash com as opções default dos tooltips do bootstrap.
    #
    # ==== Examples
    #
    #   bs_tooltip_data_options
    #   # => {toggle: 'tooltip', trigger: 'hover', placement: 'bottom', container: 'body'}
    #
    #   bs_tooltip_data_options(trigger: 'click')
    #   # => {toggle: 'tooltip', trigger: 'click', placement: 'bottom', container: 'body'}
    def bs_tooltip_data_options(options = {})
      {
        toggle:    :tooltip,
        trigger:   :hover,
        placement: :bottom,
        container: :body
      }.merge(options)
    end
  end
end
