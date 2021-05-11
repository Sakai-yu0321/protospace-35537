class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    @prototype = @user.prototypes
  end
end
