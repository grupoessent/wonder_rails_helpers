module WonderRailsHelpers
  module ActionHelper
    def action_list(model)
      I18n.t('views.actions.list', model: model.model_name.human(count: 2))
    end

    def action_new(model)
      I18n.t('views.actions.new', model: model.model_name.human)
    end

    def action_new_fem(model)
      I18n.t('views.actions.new-fem', model: model.model_name.human)
    end

    def action_back
      I18n.t('views.actions.back')
    end

    def action_edit(model)
      I18n.t('views.actions.edit', model: model.model_name.human)
    end

    def action_do_edit
      I18n.t('views.actions.do_edit')
    end

    def action_show
      I18n.t('views.actions.show')
    end

    def action_delete
      I18n.t('views.actions.delete')
    end

    alias action_index      action_list
    alias action_new_male   action_new
    alias action_new_female action_new_fem
  end
end
