class ApplicationController < ActionController::Base
  include Pundit

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Redireciona usuário logado para dashboard após login
  def after_sign_in_path_for(resource)
    dashboard_path  # substitua pelo caminho da sua página privada
  end

  # Para lidar com erros de autorização
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "Você não tem permissão para realizar essa ação."
    redirect_to(request.referrer || root_path)
  end
end
