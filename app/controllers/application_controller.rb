class ApplicationController < ActionController::API

	def authenticate_user

		# Get auth token from request header, lookup user by token
		if request.headers['Authorization']
			@current_user = User.find_by(auth_token: request.headers['Authorization'])
		end
		
		# Check whether auth token has expired
		@current_user = nil unless ( (@current_user.auth_expires_at - Time.now) > 0 )

		# If user isn't found, return an error
		if !@current_user
			render :json => {:error => "Invalid or expired auth token, please log in again"}
			return
		end
	end

end
