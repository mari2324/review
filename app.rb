require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models'

enable :sessions

get '/' do
    @reviews=Review.all
    @tags=Tag.all
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

post '/write_review' do
    r=Review.create(
        content: params[:content],
        user_id: session[:user],
    )
    tag_array = Array.new
    s=params[:tag].split(/[ 　]/)
    s.each do |sd|
        tag=Tag.find_by(tag_name: sd)
        if tag == nil
            tag=Tag.create(tag_name: sd)
        end
        tag_array << tag
    end
    r.tags=tag_array
    
    redirect '/'
end

get '/:id' do
    @user =User.find_by(id: params[:id])
    if @user.nil?
        @myreviews =[]
    else
        @myreviews=@user.reviews
    end
    erb :mypage
end

post '/:id/delete' do 
    review=Review.find_by(id: params[:id])
     review.delete
    redirect '/'
end

get '/:id/edit' do 
    @reviews=Review.all
    @tags=Tag.all
    @editreview=Review.find_by(id: params[:id])
    erb :index
    # erb :edit
end

post '/:id/edit' do
    Review.find_by(id: params[:id]).update(content: params[:edit])
    redirect '/'
end

get '/:id/review' do
    Review.where()
end

get '/write_review' do
    erb :write_review
end

post '/write_review' do
end