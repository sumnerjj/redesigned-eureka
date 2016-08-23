class UsersController < ApplicationController
  before_action :authenticate_user, except: [:create, :login_user]
  before_action :set_user, except: [:create, :login_user]

  # POST /users
  def create
		p "user create action"
		
	  # If request includes a Facebook token, get the user info from the Facebook graph
		# API, create a new user from user Facebook info, and ignore other params
		if params[:user][:facebook_token] 
			token = params[:user][:facebook_token]
			response = HTTParty.get("https://graph.facebook.com/me?access_token=#{token}")
			hash = JSON.parse response.body
			fb_id = hash["id"].to_i
			fb_name = hash["name"]
			pw = SecureRandom.urlsafe_base64
			email = SecureRandom.urlsafe_base64 + "@example.com"

			if fb_id == 0
				render :json => {:error => "Facebook token expired"} 
				return
			end
			
			@user = User.new(name: fb_name, facebook_id: fb_id, email:email, password: pw, password_confirmation: pw)
		
    # Otherwise, create a new user from name and email params
		else
			p "new from params"
			@user = User.new(user_params)
		end

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
	end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

	def login_user
		# If user logs in with Facebook token, look up the user by Facebook id
		p "user login happening"
		if params[:user][:facebook_token]
			token = params[:user][:facebook_token]
			response = HTTParty.get("https://graph.facebook.com/me?access_token=#{token}")
			hash = JSON.parse response.body
			fb_id = hash["id"].to_i
			@user = User.find_by(facebook_id: fb_id)

			if fb_id == 0
				render :json => {:error => "Facebook token expired"} 
				return
			end
		# If user logs in with email and password, use Rails' authenticate method
		else
			user = User.find_by(email: params[:user][:email])
			@user = user.authenticate(params[:user][:password])
		end

		if !@user
			render :json => {:error => "User not found"}
			return
		end

		# Generate and save a new authentication token on successful login			
		@user.generate_authentication_token
		@user.save
    render json: @user
	end

  private
    def set_user
      @user = User.find(params[:id])
      if @user != @current_user
				render :json => {:error => "Token does not match user ID"}
			  return
			end

    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :email, :facebook_id, :password, :password_confirmation)
    end

end
