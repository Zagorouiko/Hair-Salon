require('capybara/rspec')
require('./app')
require('spec_helper')
require('pry')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)
