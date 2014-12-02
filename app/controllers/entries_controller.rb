class EntriesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]

  def index
    @user = current_user
  end

  def new
    @user = current_user
    @entry = Entry.new
  end
def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      flash[:success] = "Entry created!"
      redirect_to root_url
    else
      flash[:error] = "Oops! Errors found!"
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :content, :img)
  end
end
