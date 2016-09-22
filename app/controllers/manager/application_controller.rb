class Manager::ApplicationController < ApplicationController
  before_action :pundit_manager
  layout "new_version_manager"
end
