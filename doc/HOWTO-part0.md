
Quickly configure and run the Rails App
================================================================

You can skip the tutorial and just run the app as-is if you would
like.  Here is what to do.  The first section describes how to run
locally.  The next section describes how to deploy to
[Heroku](http://heroku.com).

## Run Locally

1. Clone the project.

2. Create a file `config/env_vars.rb`.  In it, define the SightCall
   configuration variables.
   
   ```ruby
   # config/env_vars.rb
   # This file is not checked into GIT

   # Path to the CA Cert
   ENV['RTCC_CACERT'] = "/Path/To/Your/Cert/authCA.crt"

   # Paths to the extracted key and cert from the client.p12 file
   ENV['RTCC_CLIENTCERT'] =  "/Path/To/Your/Cert/publicCert.pem"
   ENV['RTCC_CLIENTCERT_KEY'] = "/Path/To/Your/Cert/privateKey.pem"

   # Password
   ENV['RTCC_CERTPASSWORD'] = "abcdefgh"

   # Auth endpoint, Client ID and Secret
   ENV['RTCC_AUTH_URL'] = "https://auth.rtccloud.net/auth/"
   ENV['RTCC_CLIENT_ID'] = "7a7a7a7a7a8b8b8b8b8b9c9c9c9c9c"
   ENV['RTCC_CLIENT_SECRET'] = "19ab19ab19ab19ab28cd28cd28cd28"

   # For the front end
   ENV['RTCC_APP_ID'] = "ab01cd34ef56"
    ```
    
3. Migrate the database.

   ```shell
   $ rake db:migrate
   ```

4. Populate the User table using the console interface.  Type the following lines into the console.

   ```shell
   $ bin/rails console
   > User.new(:name => "bob", :password => "bobpassword").save
   > User.new(:name => "sue", :password => "suepassword").save
   > User.new(:name => "tim", :password => "timpassword").save
   > User.new(:name => "pat", :password => "patpassword").save
   ```

5. Run the Rails application locally.

   ```shell
   $ bin/rails server &
   ```
   
## Run on Heroku

Read this
[article](https://devcenter.heroku.com/articles/getting-started-with-rails4)
for an overview of running Rails4 on Heroku.

1. Clone the project.

2. Put your certs in the cloned project and check them in.

   ```shell
   $ mkdir certs
   $ cp Path/To/Your/Cert/authCA.crt certs
   $ cp Path/To/Your/Cert/publicCert.pem certs
   $ cp Path/To/Your/Cert/privateKey.pem certs
   $ git add certs/*
   $ git commit -m "adding certs to the project"
   $ git push
   ```

3. Configure the project to use Postgres database and the Heroku Rails "Twelve Factor" gem.

   Modify `Gemfile`.

   ```ruby
   # Gemfile
   # gem 'sqlite3'  # comment this line out
   gem 'pg'         # add this line

   # add this for Heroku
   gem 'rails_12factor', group: :production
   ```

   Modify `config/database.yml` to specify postgres as well.

   ```yml
   # database.yml
   database: postgresql
   ```

4. Create the heroku project

   ```shell
   $ heroku create
   ```

   Confirm that Heroku is a new remote repository.
   ```shell
   $ git config -e
   ```

5. Push the code to Heroku.  This will deploy it and run it.

   ```shell
   $ git push heroku master
   ```

   This command will also print out the URL of your website.  Take note of the URL.


6.  Set all of the necessary environment variables using the heroku toolbelt.

   ```shell
   $ heroku config:set RTCC_CACERT "certs/publicCert.pem"
   $ heroku config:set RTCC_CLIENTCERT "certs/publicCert.pem"
   $ heroku config:set RTCC_CLIENTCERT_KEY "certs/privateKey.pem"
   $ heroku config:set RTCC_AUTH_URL "https://auth.rtccloud.net/auth/"
   $ heroku config:set RTCC_CLIENT_ID "7a7a7a7a7a8b8b8b8b8b9c9c9c9c9c"
   $ heroku config:set RTCC_CLIENT_SECRET "19ab19ab19ab19ab28cd28cd28cd28"
   $ heroku config:set RTCC_APP_ID "ab01cd34ef56"
   ```


7. Run the database migrations.

   ```shell
   $ heroku run rake db:migrate
   ```

8. Populate the User database using the Rails console directly.

   ```shell
   $ heroku run rails console
   > User.new(:name => "bob", :password => "bobpassword").save
   > User.new(:name => "sue", :password => "suepassword").save
   > User.new(:name => "tim", :password => "timpassword").save
   > User.new(:name => "pat", :password => "patpassword").save
   ```

9. Visit the URL of your site in Chrome for a WebRTC experience.
