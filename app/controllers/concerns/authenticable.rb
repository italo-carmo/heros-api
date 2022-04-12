module Authenticable
    private

    def authenticate_with_token
        #@ pois usaremos no controller
        @token ||= request.headers['Authorization']

        unless valid_token?
            render json: {errors: "Por favor forneça um token!"}, status: :unauthorized

        end
    end

    def valid_token?
        @token.present?
    end
end