class AdminsController < ApplicationController
  layout 'admins'

  before_action :authenticate_admin!

  # @return [Admin]
  def current_admin
    super
  end
end