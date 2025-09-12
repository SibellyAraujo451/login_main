class BookPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.admin?  # Exemplo: só admin pode criar livros
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
