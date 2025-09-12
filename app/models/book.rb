class Book < ApplicationRecord
  # Um livro pode ter muitos empréstimos
  has_many :loans, dependent: :destroy

  # Um livro pode ter muitos usuários através dos empréstimos
  has_many :users, through: :loans
end
