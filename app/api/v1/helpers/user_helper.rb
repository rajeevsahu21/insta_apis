module V1
  module Helpers
    class UserHelper
      def get_all_users(params)
        offset = params[:size] * (params[:page] - 1)
        User.order(id: :asc).limit(params[:size]).offset(offset).select(:id, :name, :email)
      end
    end
  end
end