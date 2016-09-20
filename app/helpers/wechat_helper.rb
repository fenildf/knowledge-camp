module WechatHelper
  def wechat_login
    # guest_user也算登录
    # 未登录，且未记录微信，则验证
    return true if user_signed_in?
    return true unless request.get?
    redirect_to user_wechat_omniauth_authorize_url(provider: :wechat)
    return false
  end
end
