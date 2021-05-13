class Gossip < ApplicationRecord
  has_many :comments
  has_many :tags, through: :tagossips
  belongs_to :user
  #validates :title, presence: true, length: { in: 3..14, message: "Votre titre doit être compris entre 3 et 14 caractères" } 
  validates :content, presence: true  
end
