class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: %i[show edit update destroy rent]

  # Listagem de todos os livros (apenas admin)
  def index
    if current_user.admin?
      @books = Book.all
    else
      redirect_to dashboard_path, alert: "Acesso negado."
    end
  end

  # Mostra detalhes de um livro
  def show
    if current_user.admin? || @book.user == current_user
      # ok
    else
      redirect_to dashboard_path, alert: "Acesso negado."
    end
  end

  # Novo livro (apenas admin)
  def new
    if current_user.admin?
      @book = Book.new
    else
      redirect_to dashboard_path, alert: "Acesso negado."
    end
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to books_path, notice: "Livro criado com sucesso!"  # vai para lista de livros
    else
      render :new
    end
  end

  def edit
    redirect_to dashboard_path, alert: "Acesso negado." unless current_user.admin?
  end

  def update
    if current_user.admin?
      if @book.update(book_params)
        # Redireciona para lista de livros após atualizar
        redirect_to books_path, notice: "Livro atualizado com sucesso!"
      else
        render :edit
      end
    else
      redirect_to dashboard_path, alert: "Acesso negado."
    end
  end

  def destroy
    if current_user.admin?
      @book.destroy
      redirect_to books_path, notice: "Livro excluído!"
    else
      redirect_to dashboard_path, alert: "Acesso negado."
    end
  end

  # Livros visíveis para o usuário
  def my_books
    @books = Book.all  # todos os livros para poder alugar
  end

  def rent
    @book = Book.find(params[:id])
    @loan = Loan.new(
      user: current_user,
      book: @book,
      start_date: Date.today,
      end_date: nil # ainda não devolvido
    )
    if @loan.save
      redirect_to my_loans_loans_path, notice: "Livro alugado com sucesso!"
    else
      redirect_to my_books_books_path, alert: "Não foi possível alugar o livro."
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :price)
  end
end
