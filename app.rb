require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models'

enable :sessions

get '/' do
    @reviews=Review.all
    erb :index
end

get '/sign_up' do
    erb :sign_up
end

get '/sign_in' do
    erb :sign_in
end

get '/sign_out' do
    session[:user]=nil
    redirect '/'
end

post '/sign_up' do
    @user=User.create(
        name: params[:name],
        mail: params[:mail],
        password: params[:password]
    )
    if @user.persisted?
        session[:user]=@user.id
    end
    
    redirect '/'
end

post '/sign_in' do
    user=User.find_by(mail: params[:mail])
    if user && user.authenticate(params[:password])
        session[:user]=user.id
    end
    redirect '/'
end

post '/' do
    Review.create(
        content: params[:content],
        user_id: session[:user]
    )
    redirect '/'
end

get '/:id' do
    @user =User.find_by(id: params[:id])
    if @user.nil?
        @myreviews =[]
    else
        @myreviews=@user.reviews
    # @myreviews=Review.where(user_id: params[:id])
end
    erb :mypage
end

post '/:id/delete' do 
    review=Review.find_by(id: params[:id])
     review.delete
    redirect '/'
end

get '/:id/edit' do 
    @editreview=Review.find_by(id: params[:id])
    erb :edit
end

post '/:id/edit' do
    Review.find_by(id: params[:id]).update(content: params[:edit])
    redirect '/'
end
