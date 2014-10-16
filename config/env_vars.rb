# config/env_vars.rb
# This file is not checked into GIT

# Path to the CA Cert
binding.pry
ENV['RTCC_CACERT'] = Rails.root.join('config', 'keys', 'authCA.crt').to_s

# Paths to the extracted key and cert from the client.p12 file
ENV['RTCC_CLIENTCERT'] = Rails.root.join('config', 'keys', 'publicCert.pem').to_s 
ENV['RTCC_CLIENTCERT_KEY'] = Rails.root.join('config', 'keys', "privateKey.pem").to_s

# Password
ENV['RTCC_CERTPASSWORD'] = "XnyexbUF"

# Auth endpoint, Client ID and Secret
ENV['RTCC_AUTH_URL'] = "https://auth.rtccloud.net/auth/"
ENV['RTCC_CLIENT_ID'] = "1c571d70a2cf7274efbddd1597a0b9"
ENV['RTCC_CLIENT_SECRET'] = "3bedd444c366c82cb6b0a10f559f57"

# For the front end
ENV['RTCC_APP_ID'] = "aoia9uqilfem"