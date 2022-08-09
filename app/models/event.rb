class Event < ApplicationRecord

    before_save :set_slug

    # has_many :comments, as: :readable

    has_many :registrations, dependent: :destroy
    has_many :likes, dependent: :destroy

    has_many :likers, through: :likes, source: :user

    has_many :categorizations, dependent: :destroy
    has_many :categories, through: :categorizations
    
    # validates :name, :location, :price, :description, presence: true 
    validates :name, presence: true, uniqueness: true
    validates :location, presence: true

    validates :price, numericality: { greater_than_or_equal_to: 0 }
    validates :capacity, numericality: { greater_than: 0, only_integer: true}
    validates :description, length: { minimum: 20,message: "your description length must be greater than 20" }
    validates :image_field, format: {
        with: /\w+\.(jpg|png)\z/i, message: "must be jpg or png image"
    }
    # def self.upcoming
    #     where("starts_at>?",Time.now).order("starts_at")
    # end

    scope :past,->{where("starts_at<?",Time.now).order("starts_at")}
    scope :upcoming,->{where("starts_at>?",Time.now).order("starts_at")}
    scope :free,->{upcoming.where(price: 0.0).order(:name)}
    scope :recent,->(max=3){past.limit(max)}
    def sold_out?
        (capacity - registrations.size).zero?
    end
    # accepts_nested_attributes_for :registrations





    def to_param
        slug
    end

    def set_slug
        self.slug = name.parameterize
    end
end
