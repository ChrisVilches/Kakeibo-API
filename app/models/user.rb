class User < ApplicationRecord
  devise :database_authenticatable, # :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_many :periods, -> { order(date_from: :asc) }

  validates_length_of :password, within: 6..128, allow_blank: false
end
