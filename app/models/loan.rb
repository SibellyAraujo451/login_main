# app/models/loan.rb
class Loan < ApplicationRecord
  belongs_to :user
  belongs_to :book

  # só traz empréstimos ativos
  scope :active, -> { where(end_date: nil) }
end
