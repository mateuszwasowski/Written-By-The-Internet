class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :paragraphs
  
  validates_presence_of :first_name,:last_name
  validates_length_of :first_name,:last_name, maximum: 20, message: "must be less than 20 charactes long"
  validates_length_of :first_name,:last_name, minimum: 2, message: "must be more than 2 charactes long"
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
