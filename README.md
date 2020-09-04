# WonderRailsHelpers

Helpers compartilhados para projetos Rails da Wonder Sistemas.

## Instalação

Adicione a gem ao Gemfile do projeto:

```ruby
gem 'wonder_rails_helpers', github: 'wondersistemas/wonder_rails_helpers'
```

E então execute:

```shell
$ bundle
```

Crie o arquivo `config/initializers/wonder_rails_helpers.rb` com o conteúdo:

```ruby
# config/initializers/wonder_rails_helpers.rb
WonderRailsHelpers.configure do |config|
  config.require_modules = [
    # view helpers
    :action_helper,        # necessita gem 'rails-i18n'
    :app_helper,
    :boolean_helper,
    :bootstrap_helper,
    :breadcrumb_helper,    # necessita gem 'wonder_navigation'
    :cpf_cnpj_helper,      # necessita gem 'cpf_cnpj'
    :date_time_helper,
    :error_helper,
    :model_name_helper,
    :ransack_helper,       # necessita gem 'raksack'
    :will_paginate_helper, # necessita gem 'will_paginate'

    # outras libs
    :wonder_crypt
  ]
end
```

## Uso

Documentação dos métodos inline [nos arquivos de helpers](lib/wonder_rails_helpers).

Para gerar documentação localmente basta executar:

```shell
git clone https://github.com/wondersistemas/wonder_rails_helpers.git
cd wonder_rails_helpers
rdoc
```

## To Do

- [ ] Site de documentação.
- [ ] Testes automatizados.
