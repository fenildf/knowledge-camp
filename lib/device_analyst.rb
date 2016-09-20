module DeviceAnalyst
  def is_mobile?
    AgentOrange::UserAgent.new(request.user_agent).is_mobile?
  end

  def is_android?
    request.user_agent.match(/android/i)
  end

  def is_bot?
    AgentOrange::UserAgent.new(request.user_agent).is_bot?
  end

  def is_wechat?
    request.user_agent.match(/micromessenger/i)
  end
end
