require 'sinatra'
require 'sinatra/reloader'
also_reload 'lib/**/*.rb'
require './lib/client'
require './lib/stylist'
require 'pg'
require 'pry'

DB = PG.connect({:dbname => "hair_salon"})

get('/') do
  @clients = Client.all()
  erb(:index)
end

post('/clients') do
  title = params.fetch("name")
  client = Client.new({:name => title, :id => nil})
  client.save()
  @clients = Client.all()
  erb(:index)
end

get('/clients/:id') do
  @client = Client.find(params.fetch('id').to_i())
  erb(:client)
end

post

get('/members') do
  @clients = Client.all()
  erb(:members)
end


patch('/members/:id') do
  name = params.fetch("name")
  @client = Client.find(params.fetch('id').to_i())
  @client.update({:name => name})
  erb(:members)
end

get('/client_form') do
  erb(:client_form)
end
