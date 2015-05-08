class Client

  attr_reader :name, :id

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

define_singleton_method(:all) do
  returned_clients = DB.exec("SELECT * FROM clients;")
  clients = []
  returned_clients.each do |client|
    id = client.fetch('id').to_i()
    name = client.fetch("name")
    clients.push(Client.new({:name => name, :id => id}))
  end
  clients
end

define_method(:save) do
  result = DB.exec("INSERT INTO clients (name) VALUES ('#{@name}}') RETURNING id;")
  @id = result.first().fetch("id").to_i()
  end
end