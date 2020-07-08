# frozen_string_literal: true

require 'watir'

def launch_browser
  selenium_grid_host = 'http://hub:4444/wd/hub'
  browser = Watir::Browser.new(:chrome, { url: selenium_grid_host })
end
