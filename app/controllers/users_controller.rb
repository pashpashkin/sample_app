class UsersController < ApplicationController
	before_filter :authenticate, :only => [:edit, :update]
	before_filter :correct_user, :only => [:edit, :update]
	before_filter :admin_user,   :only => :destroy
	def new
	  	if signed_in?
    		redirect_to root_path
    	else
	  		@user = User.new
	  		@title="Sing in"
	  	end
	end
	def show
	    @user = User.find(params[:id])
	    @title = @user.name
	end
  
 	def create
	    @user = User.new(params[:user])
	    if @user.save
	      sign_in @user
	      flash[:success] = "Welcome to the Sample App!"
	      redirect_to @user
	    else
	      @title = "Sign up"
	      render 'new'
	    end
	end

	def edit
    	if signed_in?
    		redirect_to root_path
    	else
    		@title = "Edit user" 	
    	end
	end

	def update
    	@user = User.find(params[:id])
	    if @user.update_attributes(params[:user])
	      flash[:success] = "Profile updated."
	      redirect_to @user
	    else
	      @title = "Edit user"
	      render 'edit'
	    end
	end

	def index
    	@title = "All users"
    	@users = User.paginate(:page => params[:page])
  	end

  	def destroy
    	
    	@user=User.find(params[:id])
    	if current_user!=@user
    		@user.destroy
    		flash[:success] = "User destroyed."	
    	end
    	redirect_to users_path
  	end


	private

	    def authenticate
	      deny_access unless signed_in?
	    end

	    def correct_user
	      @user = User.find(params[:id])
	      redirect_to(root_path) unless current_user?(@user)
	    end

	    def admin_user
      		redirect_to(root_path) unless current_user.admin?
    	end
end
