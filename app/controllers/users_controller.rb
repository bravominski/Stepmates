class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  # Show all user accounts
  def index
    if params[:search]
      @users = User.search(params[:search])
    else
      @users = User.all
    end
  end

  # GET /users/1
  # GET /users/1.json
  # Show one specific user account
  def show
  end

  # GET /users/new
  # Receive data from user for a new user account(not saved yet)
  def new
    @user = User.new
  end

  # GET /users/1/edit
  # Edit specific user account data(not saved yet)
  def edit
  end

  # POST /users
  # POST /users.json
  # With given input data, create a new user account
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        UserMailer.welcome_email(@user).deliver_now
        log_in @user
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  # With given input data, modify specific user account data.
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  # Delete specific user account data
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # Called before specific activities that deals with specific user account's data(show, update, destroy, edit)
    # to set which patient's data to run the functionality with.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # For creating and updating user account data, retrieves input data from user.
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
