##A student knocked out the power in my area,
##when I restarted I couldnt get postgres or psql up to continue working,
##the error I got was;
#FATAL:  lock file "postmaster.pid" already exists
#HINT:  Is another postmaster (PID 349) running in data directory "/Users/Guest/.
#I spent the last two hours of the review trying to fix the issue to no avail,
##is there any way I can redo the part I had remaining, and also get feedback on
#the error for future reference?

class Client

  attr_reader(:name, :id)

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
    result = DB.exec("INSERT INTO clients (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_client|
    self.name().==(another_client.name())
  end

  define_singleton_method(:find) do |id|
    found_client = nil
    Client.all().each() do |client|
      if client.id().==(id)
        found_client = client
      end
    end
    found_client
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE clients SET name = '#{@name}' WHERE id = #{@id};")

  attributes.fetch(:stylist_id, []).each() do |stylist_id|
    DB.exec("INSERT INTO appointments (client_id, stylist_id) VALUES (#{self.id()}, #{stylist_id});")

  end
end

define_method(:delete) do
  DB.exec("DELETE FROM appointments WHERE client_id = #{self.id()};")
  DB.exec("DELETE FROM clients WHERE id = #{self.id()};")
end

define_method(:stylists) do
  appointments = []
  results = DB.exec("SELECT stylist_id FROM appointments WHERE client_id = #{self.id()};")
  results.each() do |result|
    stylist_id = result.fetch("stylist_id").to_i()
    stylist = DB.exec("SELECT * FROM stylists WHERE id = #{stylist_id};")
    name = stylist.first().fetch("name")
    appointments.push(Movie.new({:name => name, :id => stylist_id}))
  end
 end
end
