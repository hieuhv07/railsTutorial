class Micropost < ApplicationRecord
	mount_uploader :picture, ::PictureUploader
	
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  validate :picture_size

  scope :newest, ->{order created_at: :desc}
  scope :micropost_following, ->(following_ids, id){where("user_id IN (?) OR user_id = ?", following_ids, id)}

  # def self.micropost_following following_ids, id
  #   where "user_id IN following_ids OR user_id = id"
  # end

  private

  def picture_size
  	if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
