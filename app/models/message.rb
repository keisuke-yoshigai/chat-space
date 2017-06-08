class Message < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  belongs_to :group
  validates :body_or_image, presence: true
  validates :group_id, presence: true
  validates :user_id, presence: true

  private

  def body_or_image
    body.present? || image.present?
  end
end
