class ApplicationController < ActionController::Base
  #ログイン認証されていなければ、ログイン画面へリダイレクトする
  #｢topページとaboutページだけはログインしていなくても表示可能としている
  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    #booksのindexページを推移先にしてしまったがそれは間違いで、正解はusersのshowページ
    user_path(current_user.id)
  end

  def after_sign_out_path_for(resource)
    #homesのtopページを推移先にした
    root_path
  end

  protected

  #deviseでnameとpassのストロングパラメーターを許可したのでサインアップはemailに変更する　ネットで調べて実装した
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
