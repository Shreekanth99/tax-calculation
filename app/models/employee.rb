class Employee < ApplicationRecord
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :phone_number, presence: true
    validates :doj, presence: true
    validates :salary, presence: true
end
