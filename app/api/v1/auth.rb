module V1
  class Auth < Grape::API
    version 'v1'
    format :json

    resources :auth do
      desc 'Register user'
      params do
        requires :name, type: String, desc: 'Name of the User'
        requires :email, type: String, desc: 'Email of the User'
        requires :password, type: String, desc: 'Password of the User'
      end
      post :signup do
        begin
          user = User.new(name: params[:name], email: params[:email], password: params[:password])
          if user.save
            cookies[:user_id] = user.id
            { message: 'account created successfully' }
          else
            status 400
            { error: 'something went wrong' }
          end
        rescue Exception => e
          status 500
          { error: e.message }
        end
      end
      desc 'Login user'
      params do
        requires :email, type: String, desc: 'Email of User'
        requires :password, type: String, desc: 'Password of the User'
      end
      post :login do
        begin
          user = User.find_by(email: params[:email].downcase)
          if user && user.authenticate(params[:password])
            cookies[:user_id] = user.id
            status 200
            { message: 'user logged in successfully' }
          else
            status 400
            { error: 'Email or password is invalid' }
          end
        rescue Exception => e
          status 500
          { error: e.message }
        end
      end
      desc 'Logout User'
      post :logout do
        if cookies[:user_id]
          cookies.delete(:user_id)
          status 200
          { message: 'User logout successfully' }
        else
          status 400
          { error: 'user is not logged in' }
        end
      end
    end
  end
end
