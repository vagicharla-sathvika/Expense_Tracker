class UsersController < ApplicationController
    def new
        @user=User.new
    end
    def create
        puts "Params received: #{params.inspect}"
        @user = User.new(email: params[:email], password: params[:password])
        if @user.save!
          token = login @user
          render json: { message: 'You have signed in successfully' , token: token}, status: :ok
        else
          render json: {errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end
end
