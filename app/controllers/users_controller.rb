class UsersController < ApplicationController
  attr_accessor :name, :email

  def show
    @user = User.find(params[:id])
    # debugger
  end

  def new
  end
end
