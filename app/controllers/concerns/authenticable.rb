module Authenticable
    private

    def authenticate_with_token
        #@ pois usaremos no controller
        @token ||= request.headers['Authorization']

        unless valid_token?
            #acesso negado:
            #render json: {errors: "Acesso negado!"}, status: :unauthorized
            render json: {errors: "Forneça um header Authorization Válido!"}, status: :unauthorized
        end
    end

    def valid_token?
        #com token fixo:
        #@token.present? && @token == Rails.application.credentials.token
        @token.present? && @token.size>=10
    end
end