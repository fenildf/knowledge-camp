module KnowledgeCampApi
  class ApplicationController < ActionController::Base
    include ::DisplayHelpers
    include ::ErrorHelpers
    include ::ApplicationHelper

    skip_before_action :verify_authenticity_token
    before_action :check_auth

    protected

    def first_key(keys, allow_nil = false)
      key = keys.detect do |k|
        params[k]
      end

      if !key && !allow_nil
        raise ActionController::ParameterMissing.new(keys.join(" || "))
      end

      key
    end

    def require_keys(keys)
      required = keys.filter do |k|
        params[k]
      end

      if required.size == 0
        raise ActionController::ParameterMissing.new(keys.join(", "))
      end

      required
    end

    def check_auth
      if !user_signed_in?
        response.headers['WWW-Authenticate'] = 'Basic realm="kc"'

        return error Unauthorized.new
      end
    end
  end
end
