class User < ApplicationRecord
  validates :first_name, :last_name, presence: true
  validates :policy, acceptance: true

  has_one :profile
  with_options dependent: :destroy do |assoc|
    assoc.has_many :posts
    assoc.has_many :experiences, through: :profile
    assoc.has_many :education_histories, through: :profile
    assoc.has_many :certifications, through: :profile
    assoc.has_many :languages, through: :profile
  end

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
end
