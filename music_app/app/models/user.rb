# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#

class User < ApplicationRecord
    validates :email, :password_digest, :session_token, presence: true
    validates :email, uniqueness: true
    after_initialize :ensure_session_token

    def self.generate_session_token
        SecureRandom.urlsafe_base64(16)             
    end

    def self.find_by_credentials(email, password)
        user = User.find_by(email: email)
        return nil if user.nil? || !user.is_password?(password)
        user
    end 

    def reset_session_token!
        self.session_token = User.generate_session_token
        self.save!
        self.session_token
    end 
    
    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        bcrypt_password = BCrypt::Password.new(self.password_digest)
        bcrypt_password.is_password?(password)
    end

    private
    def ensure_session_token
        self.session_token ||= User.generate_session_token
    end
end 
