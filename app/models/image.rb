class Image < ActiveRecord::Base
  validates :photo, presence: true

  belongs_to :property
  belongs_to :room
  mount_uploader :photo, PhotoUploader
  belongs_to :attachable, :polymorphic => true
  has_paper_trail
end
