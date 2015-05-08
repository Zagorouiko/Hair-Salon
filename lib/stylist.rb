class Stylist

  attr_reader :name, :id

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

define_singleton_method(:all) do
  returned_stylists = DB.exec("SELECT * FROM stylists;")
  stylists = []
  returned_stylists.each do |stylist|
    id = stylist.fetch('id').to_i()
    name = stylist.fetch("name")
    stylists.push(Stylist.new({:name => name, :id => id}))
  end
  stylists
end

define_method(:save) do
  result = DB.exec("INSERT INTO stylists (name) VALUES ('#{@name}') RETURNING id;")
  @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_stylist|
    self.name().==(another_stylist.name())
  end

  define_singleton_method(:find) do |id|
    found_stylist = nil
    Stylist.all().each() do |stylist|
      if stylist.id().==(id)
        found_stylist = stylist
      end
    end
    found_stylist
  end

  define_method(:clients) do
    stylist_clients = []
    clients = DB.exec("SELECT FROM clients WHERE client_id = #{self.id()};")
    clients.each() do |client|
      name = client.fetch("name")
      stylist_id = client.fetch("client_id").to_i()
      stylist_clients.push(Client.new({:name => name, :client_id => stylist_id}))
    end
    stylist_clients
  end

end
