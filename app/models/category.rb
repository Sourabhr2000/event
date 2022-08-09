class Category < ApplicationRecord
    validates :name, presence: true, uniqueness: true

    has_many :categorizations, dependent: :destroy
    has_many :events, through: :categorizations
end
