class UsersController < ApplicationController

  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    # Saving without session maintenance to skip
    # auto-login which can't happen here because
    # the User has not yet been activated
    if @user.save
      flash[:notice] = "Your account has been created."
      @users = User.all
      render :action => :index
    else
      flash[:alert] = "There was a problem creating you."
      render :action => :new
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user # makes our views "cleaner" and more consistent
    if params[:user].keys.include?(:url) and params[:user].keys.include?(:image)
      render :action => edit, :alert => "You cannot upload from file and from url in a single request. Please choose one or the other."
    else
      saved = if params[:user].keys.include?(:url)
        no_url = params[:user].except(:url)
        @user.update_attributes(no_url) and @user.image_from_url(params[:user][:url])
      else
        @user.update_attributes(params[:user])
      end
      if saved
        flash[:notice] = "Account updated!"
        redirect_to account_url
      else
        render :action => :edit
      end
    end
  end
end