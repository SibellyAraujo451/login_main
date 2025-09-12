class LoansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_loan, only: %i[show edit update destroy return_loan]

  # LISTA DE EMPRÉSTIMOS – admin
  def index
    if current_user.admin?
      # Busca todos os empréstimos, com usuário e livro
      @loans = Loan.includes(:user, :book).all
    else
      redirect_to dashboard_path, alert: "Acesso negado."
    end
  end

  # EMPRÉSTIMOS DO USUÁRIO LOGADO (ativos)
  def my_loans
    # Apenas os empréstimos que ainda não foram devolvidos (end_date nulo)
    @loans = current_user.loans.includes(:book).where(end_date: nil)
  end

  # MOSTRAR UM EMPRÉSTIMO
  def show
    # @loan já é carregado pelo set_loan
    unless current_user.admin? || @loan.user == current_user
      redirect_to dashboard_path, alert: "Acesso negado."
    end
  end

  # NOVO EMPRÉSTIMO (para admin criar manualmente)
  def new
    redirect_to dashboard_path, alert: "Acesso negado." unless current_user.admin?
    @loan = Loan.new
  end

  # CRIAR EMPRÉSTIMO
  def create
    @loan = Loan.new(loan_params)
    if @loan.save
      redirect_to current_user.admin? ? loans_path : my_loans_loans_path, notice: "Empréstimo criado!"
    else
      render :new
    end
  end

  # EDITAR EMPRÉSTIMO
  def edit
    redirect_to dashboard_path, alert: "Acesso negado." unless current_user.admin?
  end

  # ATUALIZAR EMPRÉSTIMO
  def update
    if current_user.admin? && @loan.update(loan_params)
      redirect_to loans_path, notice: "Empréstimo atualizado!"
    else
      render :edit
    end
  end

  # DELETAR EMPRÉSTIMO
  def destroy
    if current_user.admin?
      @loan.destroy
      redirect_to loans_path, notice: "Empréstimo excluído!"
    else
      redirect_to dashboard_path, alert: "Acesso negado."
    end
  end

  # DEVOLVER UM LIVRO (usuário)
  def return_loan
    if @loan.user == current_user && @loan.end_date.nil?
      @loan.update(end_date: Date.today)
      redirect_to my_loans_loans_path, notice: "Livro devolvido com sucesso!"
    else
      redirect_to my_loans_loans_path, alert: "Acesso negado ou empréstimo já devolvido."
    end
  end

  private

  def set_loan
    @loan = Loan.find(params[:id])
  end

  def loan_params
    params.require(:loan).permit(:book_id, :user_id, :start_date, :end_date)
  end
end
