class EntriesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  # Allow the current user to delete his OWN entry
  # before_action :correct_user,   only: :destroy

  # Allow admins to delete all entries
  before_action :admin_user,     only: :destroy

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
    Entry.find(params[:id]).destroy
    flash[:success] = "Entry deleted"
    redirect_to request.referrer || root_url
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :content, :img)
  end

  # def correct_user
      # @entry = current_user.microposts.find_by(id: params[:id])
      # redirect_to root_url if @entry.nil?
  # end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
