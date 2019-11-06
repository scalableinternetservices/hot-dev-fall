class Contract < ApplicationRecord
  belongs_to :sharer
  belongs_to :joiners
  validates :sharer, presence: true
  validates :joiners, presence: true
  has_many :joiners
end
