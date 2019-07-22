class MicropostsController < ApplicationController
	before_action :logged_in_user, only: %i(create destroy)
	before_action :correct_user, only: :destroy

	def create
		@micropost = current_user.microposts.build micropost_params
		if @micropost.save
			flash[:success] = "Create micropost successfully!"
			redirect_to root_path
		else
			@feed_items = []
			flash.now[:danger] = "Create micropost has problem!"
			render "static_pages/home"
		end
	end

	def destroy
		if @micropost.destroy
			flash[:success] = "Delete micropost successfully!"
			redirect_to root_path
		else
			flash[:danger] = "Delete micropost has problem!"
			redirect_to root_path
		end
	end

	private

	def micropost_params
		params.require(:micropost).permit :content, :picture
	end

	def correct_user
		@micropost = current_user.microposts.find_by id: params[:id]
	end
end