class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    callback = "#{ENV['CLIENT_URL']}/auth/homework/callback"

    service = Service.where(provider: 'homework', uid: ENV['APP_ID']).first
    unless service
      client = OAuth2::Client.new(ENV['APP_ID'], ENV['APP_SECRET'], site: ENV['PROVIDER_URL'])
      @url = client.auth_code.authorize_url(redirect_uri: callback)
    end

    @users = User.where admin: false
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        rest_api&.post(
          "#{ENV['PROVIDER_URL']}/api/users.json", 
          json: {
            user: {
              user_id: @user.id,
              name: @user.name, 
              email: @user.email, 
              password: user_params[:password]
            }
          }
        )

        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        rest_api&.put(
          "#{ENV['PROVIDER_URL']}/api/users/#{@user.id}.json", 
          json: {
            user: {
              name: @user.name
            }
          }
        )

        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    rest_api&.delete "#{ENV['PROVIDER_URL']}/api/users/#{@user.id}.json"

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

    def rest_api
      return @rest_api.client if @rest_api.present?
      @rest_api = Service.where(provider: 'homework', uid: ENV['APP_ID']).first
      @rest_api&.client
    end
end
