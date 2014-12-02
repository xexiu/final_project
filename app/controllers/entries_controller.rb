class EntriesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]

  def index
    @user = current_user
    if params[:search]
      @entries = Entry.search(params[:search]).order("created_at DESC").paginate(page: params[:page],  :per_page => 20)
    else
      @entries = Entry.all.order(created_at: :desc).limit(100).paginate(page: params[:page],  :per_page => 20)
    end
  end

  def show
    @user = current_user
    @entry = Entry.find(params[:id])
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
      @entry = []
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
