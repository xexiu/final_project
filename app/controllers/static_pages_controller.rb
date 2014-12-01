class StaticPagesController < ApplicationController
  def home
    @user = current_user
    # @entries = @user.entries.paginate(page: params[:page],  :per_page => 10)
    @entry = Entry.all
  end

  def help
  end

  def contact
  end

  def tos
  end
end
