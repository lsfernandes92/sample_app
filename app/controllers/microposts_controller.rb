class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :delete]

  def create

  end

  def delete

  end
end
