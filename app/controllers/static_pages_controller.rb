class StaticPagesController < ApplicationController
  def home
    @user = current_user
    @entries_all = Entry.all.order(created_at: :desc).paginate(page: params[:page],  :per_page => 5)
    @entries_random = Entry.order("RANDOM()").limit(100).paginate(page: params[:page],  :per_page => 5)
    # @entries = @user.entries.paginate(page: params[:page],  :per_page => 10)
    # @entries = Entry.all
  end

  def help
  end

  def contact
  end

  def tos
  end
end
