module WonderRailsHelpers
  module BreadcrumbHelper
    # Cria um breadcrumb do inspinia utilizando o wonder_navigation para gerar
    # o path completo e utilizando os action_helpers para internacionalizar
    # o model que pertence à action do controller.
    #
    # ==== Examples
    #
    #   breadcrumb_wrapper # em crm/tarefas#index
    #  # <div class="row white-bg page-heading">
    #  #   <h3>Lista de Tarefas</h3>
    #  #   <ol class="breadcrumb">
    #  #     <li><a href="/probus-server">Início</a></li>
    #  #     <li>CRM</li>
    #  #     <li><a href="/probus-server/crm/tarefas">Tarefas</a></li>
    #  #    </ol>
    #  #  </div>
    def breadcrumb_wrapper(text = nil)
      text = text_for_controller_path unless text

      return unless text

      content_for :navigation do
        content_tag :div, class: 'row white-bg page-heading' do
          content_tag(:h3, text) << navigation_breadcrumb
        end
      end
    end

    private

    def text_for_controller_path
      model_class = begin
        controller_path.classify.constantize
      rescue NameError
        nil
      end

      return nil unless model_class

      model_name_for_controller_action model_class
    end

    def model_name_for_controller_action(model_class)
      case action_name.upcase
      when 'NEW', 'EDIT'
        plural_model_name_for model_class
      when 'INDEX', 'BOARD'
        action_list model_class
      else
        singular_model_name_for model_class
      end
    end
  end
end
