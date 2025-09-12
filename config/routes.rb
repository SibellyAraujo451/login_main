Rails.application.routes.draw do
  # Rotas de configuração
  get "settings/show"
  get "settings/update"

  # Health check
  get "up", to: "rails/health#show", as: :rails_health_check

  # Página pública
  root "home#index"

  # Devise para usuários com controllers personalizados
  devise_for :users, controllers: {
    sessions: 'users/sessions'    # Para salvar email com remember_me
  }

  # Dashboard do usuário logado
  get "dashboard", to: "dashboard#index", as: :dashboard

  # Rotas RESTful para Books
  resources :books do
    collection do
      get "my_books"   # livros visíveis para o usuário logado
    end

    member do
      post "rent"      # ação para alugar livro
    end
  end

  # Rotas RESTful para Loans
  resources :loans do
    collection do
      get :my_loans   # empréstimos do usuário logado
    end

    member do
      patch :return_loan  # marca empréstimo como devolvido
    end
  end
end
