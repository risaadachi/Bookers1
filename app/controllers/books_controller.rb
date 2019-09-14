class BooksController < ApplicationController

  def index
    @book = Book.new
    @books = Book.all.order(id: "DESC")
  end

  def show
    @books = Book.all
  	@book = Book.find(params[:id])
  end

  def new
  	@books = Book.new
  end

  def edit
  	@book =Book.find(params[:id])
  end

  def create
  	@book = Book.new(book_params)
  	if @book.save
      flash[:notice] = "Book was successfully created."
  	  redirect_to book_path(@book.id)
    else
      @books = Book.all.order(id: "DESC")
      render :index
    end
  end

  def update
  	book =Book.find(params[:id])
  	if book.update(book_params)
  	  flash[:notice] = "Book was successfully updated."
      redirect_to book_path(book.id)
    else
      render("books/show")
    end
  end

  def destroy
  	book = Book.find(params[:id])
  	if book.destroy
      redirect_to books_path, notice: "Book was successfully destroyed."
    else
      render("books/index")
    end
  end

  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end
end