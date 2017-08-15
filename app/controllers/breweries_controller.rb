class BreweriesController < ApplicationController

  # GET: /breweries
  get "/breweries" do
    erb :"/breweries/index.html"
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
    erb :"/breweries/show.html"
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
