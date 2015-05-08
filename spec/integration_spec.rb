require('capybara/rspec')
require('./app')
require('spec_helper')
require('pry')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

  describe('the index path', {:type => :feature}) do
    it('allows the client to go on the stylists page to pick a stylist') do
      visit('/')
      click_link('See stylists')
      expect(page).to have_content('Hello Client')
    end
  
    it('allows the client to go on the stylists page to pick a stylist') do
      visit('/')
      click_link('Click sign up')
      expect(page).to have_content('Hello Client')
    end
  end
