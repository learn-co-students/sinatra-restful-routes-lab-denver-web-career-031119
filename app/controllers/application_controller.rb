class ApplicationController < Sinatra::Base
  use Rack::MethodOverride

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    # binding.pry
    @recipe = Recipe.create(params)
    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    # binding.pry
    erb :show
  end

  patch '/recipes/:id' do
    recipe = Recipe.find(params[:id])
    recipe.update(
      name: params[:name],
      ingredients: params[:ingredients],
      cook_time: params[:cook_time]
    )
    # binding.pry
    redirect "/recipes/#{recipe.id}"
  end

  delete '/recipes/:id' do
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect '/recipes'
  end

end
