

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
    flash[:error] = "Please login to enter a new Beer."
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
      @beer.save
    redirect "/beers"
  end
  end

  # GET: /beers/5
  get "/beers/:id" do
    @beer = Beer.find_by_id(params[:id])
    erb :"/beers/show.html"
  end

  # GET: /beers/5/edit
  get "/beers/:id/edit" do
    if logged_in?(session)
      @beer = Beer.find_by_id(params[:id])
      if @beer.user_id == current_user(session).id
        erb :"/beers/edit.html"
      else
       redirect '/beers'
      end
    else
       flash[:error] = "Must be user whom entered Beer to make changes."
  redirect '/beers'
  end
  end

  # PATCH: /beers/5
  patch "/beers/:id" do
    if params[:name] == "" || params[:brewery] == "" || params[:style] == "" || params[:abv] == "" || params[:description] == ""
    redirect "/beers/#{params[:id]}/edit"
  else
    @beer = Beer.find_by_id(params[:id])
    @beer.name = params[:name]
    @beer.brewery = Brewery.find_or_create_by(name: params[:brewery])
    @beer.abv = params[:abv]
    @beer.style = params[:style]
    @beer.description = params[:description]
    @beer.save
    redirect "/beers/#{@beer.id}"
  end
  end

  # DELETE: /beers/5/delete
  delete "/beers/:id" do
    if !logged_in?(session)
        flash[:error] = "Must be user whom entered Beer to make changes."
      redirect '/beers'
    elsif logged_in?(session)
        @beer = Beer.find_by_id(params[:id])
        if @beer.user_id == current_user(session).id
          @beer.destroy
          redirect '/beers'
      else
        flash[:error] = "Must be user whom entered Beer to make changes."
      redirect '/beers'
      end
    end
  end

end
