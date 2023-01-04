class BooksController < ApplicationController
  def new
    @book = Book.new
  end


  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    flash[:notice] = "You have created book successfully."
    #booksのshowページにリダイレクトする
    redirect_to book_path(@book.id)
    else
    @books = Book.all
    @user = current_user
    #booksのindexページのビューを表示する
    #indexで定義した変数を使用したい場合、ここでも変数を記述してあげないと使えない
    render :index
    end
  end


  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end


  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @new_book = Book.new
  end


  def edit
    @book = Book.find(params[:id])
    unless @book.user == current_user
    redirect_to books_path
    end
  end


  def update
   @book = Book.find(params[:id])
   if @book.update(book_params)
   flash[:notice] = "You have updated book successfully."
   #booksのshowページにリダイレクトする
   redirect_to book_path(@book.id)
   else
   render :edit
   end
  end


  def destroy
   @book = Book.find(params[:id])
   @book.destroy
   #booksのindexにリダイレクト
   redirect_to books_path
  end


  private
  # 投稿データのストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
