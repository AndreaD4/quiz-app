class PlayersController < ApplicationController
  layout 'players'

  before_action :authenticate_player!

  def current_player
    super
  end

  def current_company
    @company ||= current_player.company
  end
end
