class MailListsController < ApplicationController
	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(input_params)
		if @user.save
			redirect_to action: "index"
		else
			render 'new'
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
    	@user = User.find(params[:id])
    	if @user.update_attributes(input_params) 
			redirect_to action: "index"
		else
			render 'edit'
		end
	end

	private

	def input_params
		params.require(:user).permit(:firstname, :lastname, :email, :phone, :notes)
	end
end
