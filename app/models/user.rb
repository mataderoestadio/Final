class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :postulations
  has_many :jobs, through: :postulations
  enum :role, [:normal_user, :admin]     
  has_one_attached :avatar  
end
