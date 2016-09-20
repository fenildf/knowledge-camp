class AuthenticationsController < Devise::OmniauthCallbacksController
  skip_before_action :wechat_login, if: :is_wechat?

  def wechat
    omniauth_wechat_process
  end

  protected
  def omniauth_wechat_process
    omniauth = request.env['omniauth.auth']
    authentication = Authentication.where(provider: omniauth.provider, uid: omniauth.uid.to_s).first

    session[:wechat_openid] = omniauth.uid if session[:wechat_openid].blank?
    # 已有绑定，则直接登录
    if authentication
      sign_in(:user, authentication.user)
      # 跳回到之前页面
      redirect_to after_sign_in_path_for(authentication.user)
    elsif current_user
      provider = omniauth.try(:provider) || omniauth['provider']
      if current_user.bind?(omniauth.try(:provider) || omniauth['provider'])
        # 已经绑定同类
        # todo 应该提醒，并返回
      else
        # 未绑定则绑定
        authentication = Authentication.create_from_hash(omniauth, current_user)
      end
      # 跳回到之前页面
      redirect_to after_sign_in_path_for(current_user)
    else
      # 未有，创建用户，绑定
      # FIXME 未验证用户名重复问题
      user = User.new name: omniauth['info']["nickname"]
      user.save validate: false
      authentication = Authentication.create_from_hash(omniauth, user)
      if authentication
        sign_in(:user, authentication.user)
        redirect_to after_sign_in_path_for(authentication.user)
      else
        # TODO 创建Authentication失败情况
      end
    end
  end

end
