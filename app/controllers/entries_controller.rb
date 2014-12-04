class EntriesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  # Allow the current user to delete his OWN entry
  # before_action :correct_user,   only: :destroy

  # Allow admins to delete all entries
  before_action :admin_user,     only: [:destroy, :create]

  def index
    if params[:search]
      @entries = Entry.search(params[:search]).order("created_at DESC").paginate(page: params[:page],  :per_page => 20)
    else
      @entries = Entry.all.order(created_at: :desc).limit(100).paginate(page: params[:page],  :per_page => 20)
    end
  end

  def show
    @entry = Entry.find(params[:id])
  end

  def new
    @entry = Entry.new
  end

def create
    @entry = current_user.entries.build(entry_params)

    respond_to do |format|
    if @entry.save
      format.html { redirect_to @entry }
      flash[:success] = "Entry created!"
      format.json { render :show, status: :created, location: @entry }
      # redirect_to root_url
    else
      format.html { render :new, notice: 'Oops!! Errors found!' }
      format.json { render json: @entry.errors }
      # flash[:error] = "Oops! Errors found!"
      # render 'static_pages/home'
    end
  end
  end

  def destroy
    Entry.find(params[:id]).destroy
    flash[:success] = "Entry deleted"
    if entry_path
      redirect_to root_url
    else
      redirect_to request.referrer || root_url
    end
  end

  def upvote
    @entry = Entry.find(params[:id])
    unless current_user.voted_for? @entry
      @entry.vote_total = @entry.vote_total + 1
      @entry.save
      @entry.upvote_by current_user
    else
      flash[:danger] = 'Sorry!! You had allready voted this entry!'
    end
    redirect_to :back
  end

  def downvote
    @entry = Entry.find(params[:id])
    unless current_user.voted_for? @entry
      @entry.vote_total = @entry.vote_total + 1
      @entry.save
      @entry.downvote_by current_user
    else
      flash[:danger] = 'Sorry!! You had allready voted this entry!'
    end
    redirect_to :back
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
