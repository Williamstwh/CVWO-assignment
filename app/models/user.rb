class User < ApplicationRecord
    has_many :todos

    #Name must be present
    validates :name, presence: true

    #Email must be present and be unique
    validates :email, presence: true
    validates :email, uniqueness: true

    #Password must be present
    validates :password, presence: true

    #admin must be present
    validates :admin, presence: true
end
