class UsersController < ApplicationController
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
  end


  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end


  def edit
    @user = User.find(params[:id])
  unless @user == current_user
    redirect_to user_path(current_user)
  end
  end


  def update
   @user = User.find(params[:id])
   if @user.update(user_params)
   flash[:notice] = "You have updated user successfully."
   #usersのshowページにリダイレクトする
   redirect_to user_path(@user.id)
   else
   render :edit
   end
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction)
  end

#他人のユーザ情報編集画面に遷移できないようにする
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
    redirect_to user_path(current_user)
    end
  end

end