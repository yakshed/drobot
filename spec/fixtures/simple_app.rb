require 'sinatra'
class SimpleApp < Sinatra::Base
  get '/' do
    erb :simple_index
  end

  get '/login' do
    erb :simple_login
  end
  
  post '/login' do
    @authenticated = (@params[:username] == 'myuser' && @params[:password] == 'mypass')
    erb :simple_login
  end
  
  get '/other' do
    erb :simple_other
  end
end

