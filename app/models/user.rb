class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :paragraphs
  
  validates_presence_of :first_name,:last_name
  validates_length_of :first_name,:last_name, maximum: 30, message: "less than 20 if you don't mind ;)"
  validates_length_of :first_name,:last_name, minimum: 2, message: "more than 2 if you don't mind ;)"
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
