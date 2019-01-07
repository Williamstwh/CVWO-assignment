class User < ApplicationRecord
    #Downcase all emails before saving
    before_save { |user| user.email = email.downcase }

    has_many :todos

    #Name must be present
    validates :name, presence: true

    #Email must be present and be unique
    validates :email, presence: true
    validates :email, uniqueness: true

    #Password must be present
    validates :password, presence: true
end
