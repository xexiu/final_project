class Entry < ActiveRecord::Base
  belongs_to :user
  # default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 55 }
  validates :content, presence: true, length: { minimum: 300, maximum: 600 }
  validates :img, presence: true
  has_attached_file :img
  validates_attachment :img,
  :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
  validates_attachment_size :img, :less_than => 2.megabytes
end
