require 'sinatra/base'
require 'json'

class RobotWar < Sinatra::Base
  set :public_folder, 'public'

  get "/" do
    redirect '/index.html'
  end

  get '/robots/:id' do |id|
    content_type :json
    { x: 110, y: 200 }.to_json
  end
end

