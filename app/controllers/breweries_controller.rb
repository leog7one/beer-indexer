class BreweriesController < ApplicationController

  # GET: /breweries
  get "/breweries" do

    @breweries = Brewery.all
    erb :"/breweries/index.html"
  
  end

  # GET: /breweries/5
  get "/breweries/:id" do

     @brewery = Brewery.find_by_id(params[:id])
    erb :"/breweries/show.html"
 
  end
 
end
