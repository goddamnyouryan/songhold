class Provider < ApplicationRecord
  validates :uid, :name, :identifier, :token, presence: true
  belongs_to :user

  def current?
    expires_at > Time.current
  end

  def self.from_omniauth(params)
    user = find_or_initialize_by params.slice(:uid)
    user.assign_attributes params
    user.save
    user
  end
end
