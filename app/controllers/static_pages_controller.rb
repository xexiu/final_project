class StaticPagesController < ApplicationController
  def home
    @user = current_user
  end

  def help
  end

  def contact
  end

  def tos
  end
end
