module Api
  class UsersController < ApplicationController
      before_action :set_user, only: [:show, :update, :destroy]

      # GET /api/users
      def index
        @users = User.all
        render json: @users
      end

      # GET /api/users/:id
      def show
        render json: @user
      end

      # POST /api/users
      def create
        @user = User.new(user_params)

        if @user.save
          render json: @user, status: :created, location: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/users/:id
      def update
        if @user.update(user_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/users/:id
      def destroy
        @user.destroy
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:email, :password_digest)
      end
  end
end
