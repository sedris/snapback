class UsersController < ApplicationController

  before_filter :load_user_using_perishable_token, :only => [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.generate_perishable_token

    if @user.save
	  # Tell the UserMailer to send a verification email after save
	  @user.deliver_verification_instructions!
      # Set the session for the newly created user.
      redirect_to root_url, :notice => "You are signed up."
    else
      render :new
    end
  end

  def show
  	if @user
      @user.verify!
      flash[:notice] = "Thank you for verifying your account. You may now login."
    end
    redirect_to root_url
  end

	private  
	def load_user_using_perishable_token  
		@user = User.find_using_perishable_token(params[:id])
		flash[:notice] = "Unable to find your account." unless @user
	end

end