class Tag < ApplicationRecord
  has_many :tagossips
  has_many :gossips, through: :tagossips
end
