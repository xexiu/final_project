class EntriesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  # Allow the current user to delete his OWN entry
  # before_action :correct_user,   only: :destroy

  # Allow admins to delete all entries

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
    if @entry.save
      redirect_to @entry
      flash[:success] = "Entry created!"
    else
      render 'static_pages/home'
      flash[:error] = "Oops! Errors found!"
    end
  end

  def destroy
    Entry.find(params[:id]).destroy
    # flash[:success] = "Entry deleted"
    respond_to do |format|
      format.html {
        if entry_path
          redirect_to root_url
        else
          redirect_to request.referrer || root_url
        end
      }
      flash[:success] = "Entry successful deleted"
      format.html { redirect_to :back }
      format.json { head :no_content }
      format.js
    end
  end

  def upvote
    @entry = Entry.find(params[:id])
    respond_to do |format|
      unless current_user.voted_for? @entry
        format.html { redirect_to :back }
        format.json { head :no_content }
        format.js { render :layout => false }
        @entry.vote_total = @entry.vote_total + 1
        @entry.save
        @entry.upvote_by current_user
      else
        flash[:danger] = 'You allready voted this entry'
        format.html { redirect_to :back }
        format.json { head :no_content }
        format.js
      end
    end
  end

  def downvote
    @entry = Entry.find(params[:id])
    respond_to do |format|
      unless current_user.voted_for? @entry
        format.html { redirect_to :back }
        format.json { head :no_content }
        format.js { render :layout => false }
        @entry.vote_total = @entry.vote_total + 1
        @entry.save
        @entry.downvote_by current_user
      else
        flash[:danger] = 'You allready voted this entry'
        format.html { redirect_to :back }
        format.json { head :no_content }
        format.js
      end
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :content, :img)
  end

  # def correct_user
      # @entry = current_user.microposts.find_by(id: params[:id])
      # redirect_to root_url if @entry.nil?
  # end
end
