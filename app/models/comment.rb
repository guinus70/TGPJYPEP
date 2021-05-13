class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :gossip
  validates :content, presence: true, length: {minimum: 3, maximum: 400, message: "Votre commentaire doit être compris entre 3 et 400 caractères" }
end
