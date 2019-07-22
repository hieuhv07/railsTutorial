class PasswordResetsController < ApplicationController
	before_action :get_user, :valid_user, :check_expiration,
	 only: %i(edit update)

	def new; end

	def create
		@user = User.find_by email: params[:password_reset][:email].downcase
		if @user
			@user.create_reset_digest
			@user.send_password_reset_email
			flash[:info] = t ".check_email"
			redirect_to root_path
		else
			flash.now[:danger] = t ".danger"
			render :new
		end
	end

	def edit; end

	def update
		if params[:user][:password].blank?
      @user.errors.add(:password, "can't be empty")
      render :edit
    elsif @user.update_attributes user_params
      log_in @user
      @user.update_attribute :reset_digest, nil
      flash[:success] = t ".update_success"
      redirect_to @user
    else
      render :edit
    end
	end

	private

	def user_params
		params.require(:user).permit :password, :password_confirmation
	end

	def get_user
		@user = User.find_by email: params[:email]
		unless @user.present?
			flash.now[:danger] = "User not found!"
			render :new
		end
	end

	def valid_user
		unless @user && @user.activated? && @user.authenticated?(:reset, params[:id])
			flash[:warning] = t ".warning"
			redirect_to root_path
		end
	end

	def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "Password reset has expired."
      redirect_to new_password_reset_path
    end
  end
end