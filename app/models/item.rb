class Item < ApplicationRecord
    has_many :stores
    has_many :requests

    validates :name, uniqueness: true
end
