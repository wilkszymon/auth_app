class Post < ApplicationRecord
    belongs_to :user


    validates :city, presence: true
    validates :description, presence: true



end