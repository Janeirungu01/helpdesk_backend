class Users::UsersController < ApplicationController
    def index
      render json: User.all
    end
  
    def create
      user = User.new(user_params)
      if user.save
        render json: user, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      user = User.find(params[:id])
      if user.update(user_params)
        render json: user
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def getUsers
      render json: User.all
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email, :username, :password, :user_type, branch_ids: [])
    end
end
  