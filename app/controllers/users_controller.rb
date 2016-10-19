class UsersController < ApplicationController
  before_action :require_login, except: [:create, :new, :login]
  before_action :require_correct_user, only: [:show, :edit, :update, :delete]

  def new
  end

  def login
    u = User.find_by(email: params[:Email])
    if u.authenticate(params[:Password])
      session[:user_id] = u.id
      flash[:message] = []
      redirect_to "/users/#{u.id}"
    else
      flash[:message] = "Invalid"
      redirect_to '/fail'
    end
  end

  def destroy
    secret = Secret.find(params[:id])
    secret.delete_secret if secret.user == current_user
    redirect_to "/users/#{current_user.id}"
  end

  def show
    @u = User.find(params[:id])
    @secrets = @u.secrets
  end

  def register

  end

  def create
    u = User.new(name: params[:name], email: params[:email], password: params[:password], password_confirmation:params[:password_confirmation])

    if u.save
      session[:user_id]=u.id
      redirect_to "/users/#{u.id}"
    else
      flash[:error] = ["can't be blank", "invalid"]
      redirect_to '/users/new'
    end
  end

  def logout
    reset_session
    redirect_to '/sessions/new'

  end

  def edit
    @u = User.find(params[:id])
  end

  def update
    u = User.find(params[:id])
    u.update(name:params[:name])
    redirect_to "/users/#{u.id}"
  end

  def delete
    secret = Secret.find(params[:id])
    secret.delete_secret if secret.user == current_user
    redirect_to "/users/#{current_user.id}"
  end

  def secrets
    @secrets = Secret.all
  end

  def like
    secret = Secret.find(params[:id])
    Like.create(user:User.find(session[:user_id]), secret: secret)
    # redirect_to "/users/#{secret.user.id}"
    redirect_to "/secrets"
  end

  def create_secret
    u = User.find(session[:user_id])
    u.secrets.create(content: params[:content])
    redirect_to "/users/#{u.id}"
  end

  def delete_secret
    s = Secret.find(params[:id])
    id = s.user.id
    s.destroy
    redirect_to "/users/#{id}"
  end

  def unlike
    Like.find_by(user:User.find(session[:user_id]), secret: Secret.find(params[:id])).destroy
    redirect_to "/secrets"
  end
end
