class UsersController < ApplicationController

  

  # GET: /users/new
  get "/signup" do
    erb :"/users/new.html"
  end

  # POST: /users
  post "/signup" do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
      user = User.new(username: params[:username], email: params[:email], password: params[:password])
      user.save
      session[:user_id] = user.id
      redirect "/beers"
    end
  end

  # GET: /users
  get "/login" do
    if logged_in?(session)
      redirect '/beers'
    else
    erb :"/users/login.html"
    end
  end

  # POST: /users
  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
    redirect "/beers"
    else
    redirect '/login'
    end
  end

  # GET: /users/5
  get "/users/:id" do
    erb :"/users/show.html"
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    erb :"/users/edit.html"
  end

  # PATCH: /users/5
  patch "/users/:id" do
    redirect "/users/:id"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    redirect "/users"
  end

get '/logout' do
    if logged_in?(session)
      session.clear
      redirect '/login'
    else
      redirect '/login'
    end
  end



end
