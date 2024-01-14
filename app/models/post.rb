class Post < ApplicationRecord
  @@error_msg = "minimum value can't be equal to or greater than maximum value"

  validates :title, :months, :hourly_rate, :experience, :description, presence: true
  validates :title, length: { minimum: 2 }
  validates :description, length: { minimum: 50 }
  validates :skill_list, presence: true
  validate :months_span
  validate :rate_span
  validate :max_skills

  belongs_to :user

  acts_as_taggable_on :skills

  private

    def months_span
      if months!=nil and months[0] >= months[1]
        errors.add(:months, @@error_msg)
      end
    end

    def rate_span
      if hourly_rate!=nil and hourly_rate[0] >= hourly_rate[1]
        errors.add(:hourly_rate, @@error_msg)
      end
    end

    def max_skills
      if skill_list.count > 10
        errors.add(:skill_list, 'maximum 10 skills can be added')
      end
    end
end