class DashboardController < ApplicationController
  before_action :authenticate_user!  # garante que só usuários logados acessem

  def index
    # conteúdo da página privada
  end
end
