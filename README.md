# CSC-322 Curricular Planning

[![Build Status](https://travis-ci.org/CSC322-Grinnell/curricular-planning.svg?branch=master)](https://travis-ci.org/CSC322-Grinnell/curricular-planning) [![Stories in Progress](https://badge.waffle.io/CSC322-Grinnell/curricular-planning.svg?label=in%20progress&title=Stories%20In%20Progress)](http://waffle.io/CSC322-Grinnell/curricular-planning) [![Stories Needing Review](https://badge.waffle.io/CSC322-Grinnell/curricular-planning.svg?label=needs%20review&title=Stories%20Needing%20Review)](http://waffle.io/CSC322-Grinnell/curricular-planning)

## Authors

* Alex Mitchell
* Marija Ivica
* Jonathan Ackmann
* Otabek Nazarov
* Corey Simmonds 
* Prabir Pradhan 

## Setup Instructions
1. Clone this repository.
2. `cd` into the repository
3. `bundle install` to install Gem dependencies
4. `rails s` to start server

## Issues During Development
   *Rails Error: "action controller doesn't recognize term input"*
   * Run `rake db:drop db:create db:migrate`
   * 

## Instructions for deployment
    * setup account email confirmation: 
        in `/config/environments/development.rb` remove: 

        ```
        config.action_mailer.delivery_method = :smtp
        config.action_mailer.smtp_settings = {:address => "localhost", :port => 1025}
        ```
        
        in `/config/environments/production.rb` add:
        
        ```
        config.action_mailer.default_url_options = {:host => 'yourdomain.com'}
        config.action_mailer.delivery_method = :smtp
        config.action_mailer.smtp_settings = {
            :address => "127.0.0.1",
            :port    => 25,
            :domain  => 'yourdomain.com'
        }
        ```
