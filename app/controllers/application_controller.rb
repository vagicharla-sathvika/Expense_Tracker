class ApplicationController < ActionController::API
    include Pundit::Authorization
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    def login(user)
        @token = encode_token(user_id: @user.id)
        return @token
    end
    def encode_token(payload)
        JWT.encode(payload, 'hellomars1211') 
    end
    def decoded_token
        header = request.headers['Authorization']
        if header
          token = header.split(" ")[1]
          begin
            decoded_token = JWT.decode(token, 'hellomars1211', true, algorithm: 'HS256')
            Rails.logger.info("Token decoded successfully: #{decoded_token}")
            return decoded_token
          rescue JWT::DecodeError => e
            Rails.logger.error("Failed to decode token: #{e.message}")
            return nil
          end
        end
      end
      
    def current_user
      if decoded_token
        user_id = decoded_token[0]['user_id']
        Rails.logger.info("user_id: #{user_id}")
        @user = Employee.find_by(user_id: user_id)
      end
    end
    private
    def user_not_authorized
      render json: { error: "You are not authorized to perform this action." }, status: :unauthorized
   end
end
