class Menu < ApplicationRecord
  belongs_to :category
  has_one_attached :image

  # validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :category_id, presence: true
  validates :availability_status, inclusion: { in: [ true, false ] }
end
