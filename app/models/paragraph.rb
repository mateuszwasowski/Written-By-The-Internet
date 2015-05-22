class Paragraph < ActiveRecord::Base
  
  belongs_to :user
  has_many :votes, dependent: :destroy

  
  validates_presence_of :parag
  validates_length_of :parag, minimum: 200, maximum: 3000
  
end
