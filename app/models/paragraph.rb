class Paragraph < ActiveRecord::Base
  
  validates_presence_of :parag
  validates_length_of :parag, minimum: 200, maximum: 3000
  
end
