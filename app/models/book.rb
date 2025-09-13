class Book < ApplicationRecord
  # Um livro pode ter muitos empréstimos
  has_many :loans, dependent: :destroy

  # Um livro pode ter muitos usuários através dos empréstimos
  has_many :users, through: :loans

  # Validações
  validates :title, presence: { message: "não pode ficar em branco" }
  validates :author, presence: { message: "não pode ficar em branco" }
  validates :price, presence: { message: "não pode ficar em branco" },
                    numericality: { greater_than_or_equal_to: 0, message: "deve ser um número válido" }
end
