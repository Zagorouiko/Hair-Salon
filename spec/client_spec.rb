require('spec_helper')


require('spec_helper')


describe(Stylist) do

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
end
