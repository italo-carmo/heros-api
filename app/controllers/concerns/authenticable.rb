module Authenticable
    private

    def authenticate_with_token
        #@ pois usaremos no controller
        @token ||= request.headers['Authorization']

        unless valid_token?
            render json: {errors: "Acesso negado!"}, status: :unauthorized
        end
    end

    def valid_token?
        puts @token
        puts Rails.application.credentials.token
        @token.present? && @token == Rails.application.credentials.token
    end
end