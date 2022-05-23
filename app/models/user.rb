class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  before_save :downcase_email!

  validates :uid, :token, :refresh, :expires_at, presence: true

  has_many :playlists, dependent: :destroy
  has_many :providers, dependent: :destroy


  def self.from_omniauth(params)
    user = find_or_initialize_by params.slice(:uid)
    user.assign_attributes params
    user.save
    user
  end

  def downcase_email!
    self.email = email.downcase
  end

  def ringcentral
    providers.find_by name: 'Ringcentral'
  end

  def upload_hold_music(track)
    RingCentral.new(ringcentral.token).upload_custom_greeting('HoldMusic', track)
    RingCentral.new(ringcentral.token).upload_custom_greeting('ConnectingAudio', track)
  end
end
