class Client

  attr_reader :name, :id

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_clients = DB.exec("SELECT * FROM clients;")
    clients = []
    returned_clients.each do |stylist|
      id = client.fetch('id').to_i()
      name = client.fetch("name")
      clients.push(Stylist.new({:name => name, :id => id}))
    end
    clients
  end
end
