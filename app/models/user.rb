class User < ActiveRecord::Base

  # Make :password a virtual attribute of the database
  attr_accessor :password

  def rtcc_uid
    "#{name}-uid"
  end

  def rtcc_profile
    "premium"
  end

  def rtcc_domain
    "tsheffler.wauth9"
  end


  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end

  # Every time we update the password, generate a new salt
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  # The encryption scheme uses the salt
  def self.encrypted_password(password, salt)
    h = password + "rtcc" + salt
    Digest::SHA1.hexdigest(h)
  end

  # Our authentication scheme returns the user
  def self.authenticate(name, password)
    user = self.find_by_name(name)
    if user
      if user.hashed_password != encrypted_password(password, user.salt)
        user = nil
      end
    end
    user
  end
    
end
