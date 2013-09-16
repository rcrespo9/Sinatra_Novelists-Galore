require 'sinatra'
require 'sinatra/reloader'
require 'active_support/all'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => "postgresql",
  :host => "localhost",
  :username => "postgres",
  :password => "password",
  :database => "novels_and_novelists"
)

ActiveRecord::Base.logger = Logger.new(STDOUT)

require_relative './models/novel'
require_relative './models/novelist'



before do
  @nav_novelists = Novelist.all
end

get '/' do
  erb :home
end

get '/library/new' do 
	erb :"library/new"
end

post '/library/new' do
  #"INSERT INTO novelists (name, gender, date_of_birth, nationality) VALUES ('#{name}', '#{gender}', '#{date_of_birth}', '#{nationality}');"
  name = params[:name]
  gender = params[:gender]
  born = params[:born]
  died = params[:died]
  nationality = params[:nationality]
  novelist = Novelist.create(:name => name, :gender => gender, :born => born, :died => died, :nationality => nationality) 
	redirect "/"
end

get '/library/:novelist_id' do
  #SELECT id FROM novelists;
  @novelist = Novelist.find(params[:novelist_id])
	erb :"library/novelist"
end

get '/library/:novelist_id/edit' do
  #UPDATE SET;
	@novelist = Novelist.find(params[:novelist_id])
	erb :"library/edit"
end

post '/library/:novelist_id' do
  @novelist = Novelist.find(params[:novelist_id])
  if @novelist.update_attributes(params[:novelist])
    @novelist.save 
    redirect "/"
  else
    erb :"library/edit"
  end
end


get '/library/:novelist_id/delete' do
	#DELETE FROM novelists where id = x;
  @novelist = Novelist.find(params[:novelist_id]).delete
  redirect "/"
end

get '/library/:novelist_id/new_novel' do
	#"INSERT INTO novels (name, gender, date_of_birth, author_id) VALUES ('#{title}', '#{year_published}', '#{genre}', '#{author_id}');"
	@novelist_id = params[:novelist_id]
	erb :"library/new_novel"
end

post '/library/:novelist_id/create_novel' do
	novelist = Novelist.find(params[:novelist_id])
	novel = novelist.novels.new
  novel.title = params[:novel][:title]
  novel.year_published = params[:novel][:year_published]
  novel.genre = params[:novel][:genre]
	novel.save

	redirect '/'
end