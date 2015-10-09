# type 'bundle install' in command line to install any missing gems

# how to run server:
# shotgun -o 0.0.0.0 -p 3000
require 'bundler'
Bundler.require

# import local file to be accessed
require_relative 'models/userpicks.rb'
require_relative 'twilio.rb'

class MyApp < Sinatra::Base

  get '/' do # route
    @new = Items.new
    erb :index
  end
  
  get '/infopage' do
    erb :infopage
  end
  
  post '/check' do
    @picks = UserPicks.new(params[:pick])
    @info = Info.new(params[:name], params[:number])
    @new = Items.new
    
    if @picks.pick == "street harassment"
      @message = "#{@info.name} listed you as an emergency contact. They are currently at risk for street harassment. Please contact or locate them to ensure their safety."
    elsif @picks.pick == "domestic violence"
      @message = "#{@info.name} listed you as an emergency contact. They are currently at risk for domestic violence. Please contact or locate them to ensure their safety."
    elsif @picks.pick == "rape"
      @message = "#{@info.name} listed you as an emergency contact. They are currently at risk for rape. Please contact or locate them to ensure their safety."
    elsif @picks.pick == "other"
      @message = "#{@info.name} listed you as an emergency contact. Please contact or locate them to ensure their safety."
    else
      erb :error
    end
    send_message(@message, @info.number)
    erb :index
  end
end