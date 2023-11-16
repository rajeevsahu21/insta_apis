module API
  module V1
    class Authentication < Grape::API
      prefix 'api'
      version 'v1'
      format :json
      resources :auth do
        desc 'Register user'
        params do
          requires :name, type: String, desc: 'Name of User'
          requires :email, type: String, desc: 'Email of User'
        end
        post :signup do
          user = User.new(name: params[:name], email: params[:email])
          if user.save
            { message: 'account created successfully' }
          else
            { message: 'something went wrong' }
          end
        end
        desc 'Login user'
        params do
          requires :email, type: String, desc: 'Email of User'
        end
        post :login do
          user = User.find_by(email: params[:email])
          if user
            { message: 'user found successfully' }
          else
            { message: 'No User found with this email' }
          end
        end
      end
    end
  end
end