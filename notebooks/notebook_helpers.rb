# frozen_string_literal: true

Warning[:deprecated] = false
require 'dotenv'
require 'amazing_print'
# set the irb variable for amazing print
IRB = 'true'
Dotenv.load('../.env')
def display_link(url, title = nil)
  title ||= url
  IRuby.html("<a target=\"_blank\" href=\"#{url}\">#{title}</a>")
end

def display_html(html)
  IRuby.html(html)
end

def take_screenshot(browser)
  img_data = browser.screenshot.base64
  src = 'data:image/png;base64,' + img_data
  IRuby.display "<img src='#{src}' />", mime: 'text/html'
end
