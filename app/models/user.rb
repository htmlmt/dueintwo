class User < ActiveRecord::Base
  has_many :items
  has_many :loans
  has_many :messages
  mount_uploader :photo, PhotoUploader
  after_update :crop_photo
  
  def crop_photo
    photo.recreate_versions! if crop_x.present?
  end
  
  extend FriendlyId
  friendly_id :username, use: :slugged
  
  attr_accessor :stripe_card_token, :crop_x, :crop_y, :crop_w, :crop_h
  
  authenticates_with_sorcery!

  validates :email, uniqueness: true
  
  def stripe_recipient
    return nil if stripe_recipient_id.nil?
    Stripe::Recipient.retrieve stripe_recipient_id
  end
end
