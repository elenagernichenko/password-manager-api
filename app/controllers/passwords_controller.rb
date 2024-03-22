class PasswordsController < ApplicationController
  before_action :set_password, only: [:show, :update, :destroy]

  # GET /users/:user_id/passwords
  def index
    @passwords = Password.all
    render json: @passwords
  end

  # GET /users/:user_id/passwords/:id
  def show
    render json: @password
  end

  # POST /users/:user_id/passwords/:id
  def create
    @password = Password.new(password_params)

    if @password.save
      render json: @password, status: :created, location: @password
    else
      render json: @password.errors, status: unprocessable_entity
    end
  end

  # PUT/PATCH /users/:user_id/passwords/:id
  def update
    if @password.update(password_params)
      render json: @password
    else
      render json: @password.errors, status: unprocessable_entity
    end
  end

  # DELETE /users/:user_id/passwords/:id
  def destroy
    @password.destroy

    # after successful deletion of the user
    # we are giving 204 code which means the
    # server has processed the request and doesn't
    # return any content

    head 204
  end

  private

  def set_password
    @password = Password.find(params[:id])
  end

  def password_params
    params.require(:password).permit(:user_id, :resource_name, :login, :password_encrypted)
  end
end
