class Stylist

  attr_reader(:name, :id)

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

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE stylists SET name = '#{@name}' WHERE id = #{@id};")

    attributes.fetch(:client_id, []).each() do |client_id|
      DB.exec("INSERT INTO appointments (client_id, stylist_id) VALUES (#{client_id}, #{self.id()});")
    end
  end

  define_method(:delete) do
    DB.exec("DELETE FROM appointments WHERE stylist_id = #{self.id()};")
    DB.exec("DELETE FROM stylists WHERE id = #{self.id()};")
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE stylists SET name = '#{@name}' WHERE id = #{self.id()};")

    attributes.fetch(:client_id, []).each() do |client_id|
      DB.exec("INSERT INTO appointments (client_id, stylist_id) VALUES (#{client_id}, #{self.id()});")
    end
  end

  define_method(:clients) do
    appointments = []
    results = DB.exec("SELECT client_id FROM appointments WHERE stylist_id = #{self.id()};")
    results.each() do |result|
      client_id = result.fetch("client_id").to_i()
      client = DB.exec("SELECT * FROM clients WHERE id = #{client_id};")
      name = client.first().fetch("name")
      appointments.push(Client.new({:name => name, :id => client_id}))
    end
  end
end
