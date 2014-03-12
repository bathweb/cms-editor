require 'sinatra'
require 'sinatra/reloader' if development?

require 'haml'

require 'restclient'
require 'json'

get '/' do

  repo = JSON.parse(RestClient.get "https://api.github.com/repos/bbcrd/REST-API-example")
  @title = repo['description']
  @main  = RestClient.get "https://api.github.com/repos/bbcrd/REST-API-example/readme", {:accept => 'application/vnd.github.raw+json'}

  @pageTitle = "Editing: #{@title}"

  haml :editor

end

post '/save' do

  @html = RestClient.post "https://api.github.com/markdown/raw", params[:main], :content_type => 'text/x-markdown'

  @title = params[:title]
  @main  = params[:main]

  @pageTitle = "Saved: #{@title}"

  haml :save

end

get '/save' do

  redirect to('/')

end