class BreweriesController < ApplicationController

  # GET: /breweries
  get "/breweries" do
    if logged_in?(session)
    @breweries = Brewery.all
    erb :"/breweries/index.html"
  else
    redirect '/'
  end
  end

  # GET: /breweries/new
  get "/breweries/new" do
    erb :"/breweries/new.html"
  end

  # POST: /breweries
  post "/breweries" do
    redirect "/breweries"
  end

  # GET: /breweries/5
  get "/breweries/:id" do

    if logged_in?(session)
     @brewery = Brewery.find_by_id(params[:id])
    erb :"/breweries/show.html"
  else
    redirect '/'
  end
  end

  # GET: /breweries/5/edit
  get "/breweries/:id/edit" do
    erb :"/breweries/edit.html"
  end

  # PATCH: /breweries/5
  patch "/breweries/:id" do
    redirect "/breweries/:id"
  end

  # DELETE: /breweries/5/delete
  delete "/breweries/:id/delete" do
    redirect "/breweries"
  end
end
