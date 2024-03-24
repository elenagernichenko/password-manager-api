module Api
  class PasswordsController < ApplicationController
    before_action :set_user
    before_action :set_password, only: [:show, :update, :destroy]

    # GET /api/users/:user_id/passwords
    def index
      @passwords = @user.passwords
      render json: @passwords
    end

    # GET /api/users/:user_id/passwords/:id
    def show
      render json: @password
    end

    # POST /api/users/:user_id/passwords
    def create
      @password = @user.passwords.new(password_params)

      if @password.save
        render json: @password, status: :created, location: api_user_password_url(@user, @password)
      else
        render json: @password.errors, status: unprocessable_entity
      end
    end

    # PUT/PATCH /api/users/:user_id/passwords/:id
    def update
      if @password.update(password_params)
        render json: @password
      else
        render json: @password.errors, status: unprocessable_entity
      end
    end

    # DELETE /api/users/:user_id/passwords/:id
    def destroy
      @password.destroy

      # after successful deletion of the user
      # we are giving 204 code which means the
      # server has processed the request and doesn't
      # return any content

      head 204
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_password
      @password = @user.passwords.find(params[:id])
    end

    def password_params
      params.require(:password).permit(:resourse_name, :login, :password_encrypted)
    end
  end
end
