class LoginsController < ApplicationController
    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
          render json: { message: "You have logged in successfully"}, status: :ok
        else
          render json: { error: "Invalid username or password" }, status: :unauthorized
        end
    end
end
