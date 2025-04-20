class ManagersController < ApplicationController
  layout 'managers'

  before_action :authenticate_manager!

  def current_manager
    super
  end

  def current_company
    @company ||= current_manager.company
  end
end