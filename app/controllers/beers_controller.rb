class BeersController < ApplicationController

  # GET: /beers
  get "/beers" do
    @beers = Beer.all
    erb :"/beers/index.html"
  end

  # GET: /beers/new
  get "/beers/new" do
    if logged_in?(session)
    erb :"/beers/new.html"
  else
    redirect '/login'
  end
  end

  # POST: /beers
  post "/beers" do
    if params[:name] == "" || params[:brewery] == "" || params[:style] == "" || params[:abv] == "" || params[:description] == ""
      redirect '/beers/new'
    else
      @beer = current_user(session).beers.create(name: params[:name], style: params[:style], abv: params[:abv], description: params[:description])
      @beer.brewery = Brewery.find_or_create_by(name: params[:brewery])
    redirect "/beers"
  end
  end

  # GET: /beers/5
  get "/beers/:id" do
    
    erb :"/beers/show.html"
  end

  # GET: /beers/5/edit
  get "/beers/:id/edit" do
    erb :"/beers/edit.html"
  end

  # PATCH: /beers/5
  patch "/beers/:id" do
    redirect "/beers/:id"
  end

  # DELETE: /beers/5/delete
  delete "/beers/:id/delete" do
    redirect "/beers"
  end
end
