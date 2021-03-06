

class UsersController < ApplicationController


  # GET: /users/new
  get "/signup" do
      if logged_in?(session)
        redirect "/beers"
     else
        erb :"/users/new.html"
      end
  end

  # POST: /users
  post "/signup" do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      flash[:error] = "Please fill in all fields."
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
      flash[:error] = "Incorrect Username or Password"
    redirect '/login'
    end
  end

  # GET: /users/5
  get "/users/:id" do
     if !logged_in?(session)
        flash[:error] = "Must be logged in to view your beer profile."
      redirect '/beers'
    elsif logged_in?(session)
     @user = User.find_by_id(params[:id])
     if @user.id == current_user(session).id
     @beers = @user.beers
    erb :"/users/show.html"
    else
    flash[:error] = "Must be logged in to view your beer profile."
    redirect '/beers'
    end
  end
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
     if logged_in?(session)
      @user = User.find_by_id(params[:id])
      if @user.id == current_user(session).id
        erb :"/users/edit.html"
      else
       redirect '/beers'
      end
    else
       flash[:error] = "Must be logged in to edit User Profile."
  redirect '/beers'
  end
   
  end

  # PATCH: /users/5
  patch "/users/:id" do
    if params[:username] == "" || params[:email] == ""
      redirect "/users/#{params[:id]}/edit"
    else
      @user = User.find_by_id(params[:id])
      @user.username = params[:username]
      @user.email = params[:email]
      if @user.authenticate(params[:old_password]) && 
        params[:new_password] != "" && 
        params[:new_password_confirmation] != ""
          @user.password = params[:new_password]
          @user.password_confirmation = params[:new_password_confirmation]
      end
      @user.save
      redirect "/users/#{@user.id}"
    end
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    if !logged_in?(session)
        flash[:error] = "Must be user whom created account to make changes."
      redirect '/beers'
    elsif logged_in?(session)
        @user = User.find_by_id(params[:id])
        if @user.id == current_user(session).id
          @user.destroy
          redirect '/beers'
        else
        flash[:error] = "Must be user whom created account to make changes."
        redirect '/beers'
        end
      end
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
