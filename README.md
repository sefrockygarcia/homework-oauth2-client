# OAuth Client App
As an OAuth Client, I need to connect to an OAuth Provider so that I can share my data to them or vice versa.

## Requirements

 1. Ruby -v 3.0.3
 2. Rails -v 6.1.4.4
 3. Yarn

## Guide

 1. Run `bundle install`
 2. Set ENV variables
   1. `export CLIENT_URL=http://localhost:3001`
   2. `export PROVIDER_URL=http://localhost:3000`
   3. `export APP_ID=STRING`
   4. `export APP_SECRET=STRING`
 3. Run `rails db:create db:migrate db:seed`
 4. Default user is `admin@example.com` `password`
 5. Run `rails server -p 3001`
 6. Demo video [here](https://drive.google.com/file/d/1iaNihKpNIVmPJkHq_t4RcTUQ354MMV8a/view?usp=sharing)