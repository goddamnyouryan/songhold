class Playlist < ApplicationRecord
  validates :uid, presence: true
  belongs_to :user

  def tracks

  end
end
