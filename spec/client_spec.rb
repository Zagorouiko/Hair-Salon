require('spec_helper')


describe(Client) do

  describe(".all") do
    it("starts off with no clients") do
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

  describe('#save') do
    it('adds the client to the database') do
      test_client = Client.new({:name => "new client", :id => nil})
      test_client.save()
      expect(Client.all()).to(eq([test_client]))
    end
  end
end
