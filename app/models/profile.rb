class Profile < ApplicationRecord
  validates :professional_role, :bio, :hourly_rate, :phone, :country, :street_address, :city, :state, :skill_list, :service_list, presence: true
  validates :professional_role, length: {minimum: 4}
  validates :bio, length: {minimum: 100}
  validates :hourly_rate, numericality: {in: 3..999}, allow_nil: true
  validates :phone, length: {is: 10}, uniqueness: true

  belongs_to :user
  with_options dependent: :destroy do |assoc|
    assoc.has_many :experiences
    assoc.has_many :education_histories
    assoc.has_many :languages
    assoc.has_many :certifications
  end
  has_one_attached :avatar
  accepts_nested_attributes_for :experiences, :education_histories, :certifications, :languages, reject_if: :all_blank, allow_destroy: true
  acts_as_taggable_on :skills, :services

  delegate :first_name, :last_name, to: :user

  private

    def max_skills
      if skill_list.count > 15
        errors.add(:skill_list, 'maximum 15 skills can be added')
      end
    end
end
