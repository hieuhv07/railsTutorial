class UsersController < ApplicationController
  before_action :load_user, only: %i(show edit update destroy)
  before_action :logged_in_user, only: %i(index show edit update destroy)
  before_action :correct_user, only: %i(edit)
  before_action :admin_user, only: %i(destroy)

  def index
    @users = User.newest.paginate page: params[:page], per_page: 10
  end

  def show
    @microposts = 
      @user.microposts.newest.paginate page: params[:page], per_page: 10
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_path
    else
      flash.now[:danger] = t ".error"
      render :new
    end
  end

  def edit; end

  def update
    @user.update_attributes user_params
    if @user.save
      flash[:success] = t ".success_update"
      redirect_to @user
    else
      flash[:danger] = t ".error_update"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".success"
      redirect_to users_path
    else
      flash[:danger] = t ".error"
      redirect_to users_path
    end
  end

  private

  def load_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit :name, :email,
      :password, :password_confirmation
  end

  def correct_user 
    @user = User.find params[:id]
    unless current_user?(@user)
      flash[:danger] = t ".permission"
      redirect_to root_path
    end
  end

  def admin_user
    unless current_user.admin?
      flash[:danger] = t ".permission"
      redirect_to root_path
    end
  end
end
