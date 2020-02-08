class Ingredient < ApplicationRecord
  has_many :doses
  validates :name, presence: true, uniqueness: true

  API_URL = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
end
