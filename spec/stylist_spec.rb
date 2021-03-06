require('spec_helper')
require('pry')
require('client')


describe(Stylist) do

  describe(".all") do
    it("starts off with no clients") do
      expect(Stylist.all()).to(eq([]))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      stylist = Stylist.new({:name => "Bob", :id => nil})
      stylist.save()
      expect(stylist.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#name") do
    it("tells you the name")do
    stylist = Stylist.new({:name => "Bob", :id => nil})
    stylist.save()
    expect(stylist.name()).to(eq('Bob'))
  end
end

  describe('#save') do
    it('adds the stylist to the database') do
      test_stylist = Stylist.new({:name => "new stylist", :id => nil})
      test_stylist.save()
      expect(Stylist.all()).to(eq([test_stylist]))
    end
  end

  describe("#==") do
    it("is the same stylist if it has the same name") do
    stylist1 = Stylist.new({:name => "Bob", :id => nil})
    stylist2 = Stylist.new({:name => "Bob", :id => nil})
    expect(stylist1).to(eq(stylist2))
  end
 end

 describe(".find") do
   it("returns a stylist by their ID") do
     test_stylist = Stylist.new({:name => "Bob", :id => nil})
     test_stylist.save()
     test_stylist2 = Stylist.new({:name => "BobBob", :id => nil})
     test_stylist2.save()
     expect(Stylist.find(test_stylist2.id())).to(eq(test_stylist2))
   end
 end

 describe("#update") do
   it("lets you update stylists in the database") do
     stylist = Stylist.new({:name => "Robert", :id => nil})
     stylist.save()
     stylist.update({:name => "Sam"})
     expect(stylist.name()).to(eq("Sam"))
   end
 end

 describe("#delete") do
   it("lets you delete a stylist from the database") do
     stylist = Stylist.new({:name => "Robert", :id => nil})
     stylist.save()
     stylist2 = Stylist.new({:name => "Sam", :id => nil})
     stylist2.save()
     stylist.delete()
     expect(Stylist.all()).to(eq([stylist2]))
   end
  end
end
