# CSC-322 Curricular Planning

[![Build Status](https://travis-ci.org/CSC322-Grinnell/curricular-planning.svg?branch=master)](https://travis-ci.org/CSC322-Grinnell/curricular-planning) [![Stories in Progress](https://badge.waffle.io/CSC322-Grinnell/curricular-planning.svg?label=in%20progress&title=Stories%20In%20Progress)](http://waffle.io/CSC322-Grinnell/curricular-planning) [![Stories Needing Review](https://badge.waffle.io/CSC322-Grinnell/curricular-planning.svg?label=needs%20review&title=Stories%20Needing%20Review)](http://waffle.io/CSC322-Grinnell/curricular-planning)

## Authors

* Jonathan Ackmann
* Marija Ivica
* Alex Mitchell
* Otabek Nazarov
* Prabir Pradhan 
* Corey Simmonds 

## System Dependencies
  Depending on your platform, you will acquire these packages in different ways. You should consult the documentation for your operating system to determine the proper way to install these programs.

* `ruby` 2.3
* `rails` 4.1
* `gem` 2.5
* `bundler` 1.14
  * This can be installed via `gem` as follows: `gem install bundler`

## Basic Environment Initialization
0. Ensure all above system dependencies are installed
1. Clone this repository.
2. `cd` into the repository
3. `bundle install` to install Gem dependencies
4. `rails s` to start server

### Additional Development Environment Configuration
#### Issues During Development
  *Rails Error: "action controller doesn't recognize term input"*
    * Run `rake db:drop db:create db:migrate`

### Additional Production Environment Configuration
    * By default, Rails will listen on port 3000.
      * Use `ModProxy` on Apache or similar to forward traffic from existing infrastructure
    * Configure mailer subsystem for user email confirmation: 
        1. in `/config/environments/development.rb` remove: 

        ```
        config.action_mailer.delivery_method = :smtp
        config.action_mailer.smtp_settings = {:address => "localhost", :port => 1025}
        ```
        
        2. in `/config/environments/production.rb` add:
        
        ```
        config.action_mailer.default_url_options = {:host => 'yourdomain.com'}
        config.action_mailer.delivery_method = :smtp
        config.action_mailer.smtp_settings = {
            :address => "127.0.0.1",
            :port    => 25,
            :domain  => 'yourdomain.com'
        }
        ```
