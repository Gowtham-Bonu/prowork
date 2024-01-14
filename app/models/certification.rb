class Certification < ApplicationRecord
  belongs_to :profile

  validates :issue_date, :name, presence: true
  validates :cert_id, uniqueness: true
  validate :valid_url, if: ->{ !certification_url.blank? }
  validate :date_comparison, if: -> { expiration_date and issue_date }
  
  private

    def valid_url
      unless certification_url.starts_with? 'https://' and certification_url.ends_with? '.com'
        errors.add(:certification_url, 'must be a valid url, for example: https://sampler.com')
      end
    end

    def date_comparison
      unless issue_date < expiration_date
        errors.add(:issue_date, 'issue date must be less than expiration date')
      end
    end
end