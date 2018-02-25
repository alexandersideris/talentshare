class CompaniesController < ApplicationController
	before_action :authenticate_company!, only: [:new, :edit, :update, :destroy]

	def index
		@companies = Company.all
		@lists = List.all
	end

	def new
		@company = Company.new
	end

	def create
	    @company = Company.new(post_params)

	    if @company.save
	      redirect_to "/"
	    else
	      render 'new'
	    end
  	end

	def destroy
		@company = Company.find(current_company.id)

	    @company.destroy
	    redirect_to "/"
	end

	def edit_profile
		@company = Company.find(current_company.id) 
	end

  	def update
    	@company = Company.find(current_company.id)

    	if @company.update(post_params)
      		redirect_to "/"
    	else
      		render 'edit'
    	end
  	end

  	def profile
    	@company = Company.find(current_company.id)
  	end

  	def edit_lists
  		@lists = List.where(:company => current_company.id)
  	end

  	def lists
  		@company = Company.find(params[:id])
  		@lists = List.where(:company => params[:id])
  	end

  	private

	def post_params
		params.require(:company).permit(:name, :description, :url, :location, :image, :email, :pasword, :password_confirmation)
	end

end