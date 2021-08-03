class User < ApplicationRecord

    has_many :posts

    validates :username, 
                presence: true, 
                length: { in: 4..20 },
                uniqueness: { case_sensitive: false }

VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email,
                presence: true,
                uniqueness: true,
                format: { with: VALID_EMAIL }

has_secure_password


def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_initialize do |user|
      user.username = auth.info.name
      user.email = auth.info.email
      if auth.info.uid
        user.uid = auth.info.uid
      end
      user.password = SecureRandom.hex
    end
  end

end
