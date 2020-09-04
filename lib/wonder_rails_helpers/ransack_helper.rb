module WonderRailsHelpers
  module RansackHelper
    # Cria o link de ordenação do ransack pelo ransack.
    # Utiliza variável @query do controller.
    #
    # === Examples
    #
    # ransack_sort_link :name
    # => <a href="?q[order]=name%20%desc">Nome</a>
    # # ransack_sort_link :name, query: @q
    # => # utiliza variável @q do controller
    # => <a href="?q[order]=name%20%desc">Nome</a>
    def ransack_sort_link(attribute, options = {})
      query = options[:query] || @query

      sort_link query, attribute, query.klass.human_attribute_name(attribute), options
    end

    # Permite utilizar search_form_for com a sintaxe do simple_form.
    #
    # === Examples
    #
    # <%= simple_search_form_for @q do |f| %>
    #   <%= f.input :name_eq %>
    # <% end %>
    def simple_search_form_for(query, options = {}, &block)
      search_form_for(query, options.merge(builder: SimpleForm::FormBuilder), &block)
    end
  end
end
