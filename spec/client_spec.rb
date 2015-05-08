require('spec_helper')


require('spec_helper')


describe(Stylist) do

  describe(".all") do
    it("starts off with no clients") do
      expect(Client.all()).to(eq([]))
    expect(Client.all()).to(eq([]))
  end
end

  describe("#id") do
    it("sets its ID when you save it") do
      client = Client.new({:name => "Bob", :id => nil})
      client.save()
      expect(client.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#name") do
    it("tells you the name")do
    client = Client.new({:name => "Bob", :id => nil})
    client.save()
    expect(client.name()).to(eq('Bob'))
  end
 end

 describe('#save') do
   it('adds the client to the database') do
     test_client = Client.new({:name => "new client", :id => nil})
     test_client.save()
     expect(Client.all()).to(eq([test_client]))
   end
 end

 describe("#==") do
   it("is the same client if it has the same name") do
     client1 = Client.new({:name => "Bob", :id => nil})
     client2 = Client.new({:name => "Bob", :id => nil})
     expect(client1).to(eq(client2))
   end
 end

 describe(".find") do
   it("returns a list by its ID") do
     test_client = Client.new({:name => "Bob", :id => nil})
     test_client.save()
     test_client2 = Client.new({:name => "BobBob", :id => nil})
     test_client2.save()
     expect(Client.find(test_client2.id())).to(eq(test_client2))
   end
 end
end
