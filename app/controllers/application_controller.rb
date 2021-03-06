class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?

# ログイン後遷移
 def after_sign_in_path_for(resource)
    user_path(current_user.id)
 end
# 新規登録後遷移
 def after_sign_up_path_for(resource)
     user_path(current_user.id)
 end
# ログアウト後遷移
  def after_sign_out_path_for(resource)
    root_path
  end

 protected

# devise.rbをemailからnameにした為、emailは許可が必要になる
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
