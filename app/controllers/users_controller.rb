class UsersController < ApplicationController
  def new
  	@title="Sing in"
  end
  def show
    @user = User.find(params[:id])
  end

end
