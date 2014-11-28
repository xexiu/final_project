class UsersController < ApplicationController
  layout 'layout_profiles'
  attr_accessor :name, :email

  def show
    @user = User.find(params[:id])
    # debugger
  end

  def new
    @user = User.new
  end
end
