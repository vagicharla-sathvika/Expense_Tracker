class User < ApplicationRecord
    has_many :employee
    has_secure_password
    validates :email,presence:true
    # validates :pasword,presence:true
end
