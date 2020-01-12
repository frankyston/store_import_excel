class Company < ApplicationRecord
  validates :name, :code, :token, presence: true
end
