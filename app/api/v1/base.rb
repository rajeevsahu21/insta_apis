module V1
  class Base < Grape::API
    prefix 'api'
    mount V1::AuthApi
    mount V1::PostApi
    mount V1::UserApi
  end
end