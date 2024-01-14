class EducationHistory < ApplicationRecord
  belongs_to :profile
  validates :school, presence: true
  validate :date_comparison
end

private

  def date_comparison
    if from and to
      unless from < to
        errors.add(:from, 'start date must be less than end date')
      end
    elsif to and !from
      errors.add(:from, 'from should also be present')
    end
end
