class BeersController < ApplicationController

  # GET: /beers
  get "/beers" do
    @beers = Beer.all
    @brewery = Brewery.all
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
      @brewery = Brewery.find_or_create_by(name: params[:brewery])
    redirect "/beers"
  end
  end

  # GET: /beers/5
  get "/beers/:id" do
    if logged_in?(session)
      @beer = Beer.find_by_id(params[:id])
      @brewery = Brewery.find_by_id(params[:id])
    erb :"/beers/show.html"
    else
    redirect '/'
    end
  end

  # GET: /beers/5/edit
  get "/beers/:id/edit" do
    if logged_in?(session)
      @beer = Beer.find_by_id(params[:id])
      @brewery = Brewery.find_by_id(params[:id])
      if @beer.user_id == current_user(session).id
        erb :"/beers/edit.html"
      else
       redirect '/beers'
      end
    else
  redirect '/'
  end
  end

  # PATCH: /beers/5
  patch "/beers/:id" do
    if params[:name] == "" || params[:brewery] == "" || params[:style] == "" || params[:abv] == "" || params[:description] == ""
    redirect "/beers/#{params[:id]}/edit"
  else
    @beer = Beer.find_by_id(params[:id])
    @brewery = Brewery.find_by_id(params[:id])
    @beer.name = params[:name]
    @brewery.name = params[:brewery]
    @beer.abv = params[:abv]
    @beer.style = params[:style]
    @beer.description = params[:description]
    @beer.save
    @brewery.save
    redirect "/beers/#{@beer.id}"
  end
  end

  # DELETE: /beers/5/delete
  delete "/beers/:id" do
    if logged_in?(session)
      @beer = Beer.find_by_id(params[:id])
      @brewery = Brewery.find_by_id(params[:id])
      if @beer.user_id == current_user(session).id
        @beer.destroy
        @brewery.destroy
        redirect '/beers'
      end
    redirect "/"
  end
  end
end
