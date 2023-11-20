class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    protect_from_forgery with: :exception

    # ログイン済ユーザーのみにアクセスを許可する
  #  before_action :authenticate_user!
  
    # deviseコントローラーにストロングパラメータを追加する          
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    #ログイン後に遷移したいページを指定
    def after_sign_in_path_for(resource)
      root_path
    end
    #  ログアウト後に遷移したいページを指定
    def after_sign_out_path_for(resource)
      root_path
    end
  
    
  
    private
    def sign_in_required
      #  showページはログインしているユーザーだけにアクセスさせ、ログインしてない場合はログインページに遷移させる
      redirect_to new_user_session_url unless user_signed_in?
    end

  
    protected
    def configure_permitted_parameters
      # ユーザー登録時にnameのストロングパラメータを追加（サインアップ時にnameを入力する場合は追記）
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      # ユーザー編集時にnameとprofileのストロングパラメータを追加
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile])
    end
end
