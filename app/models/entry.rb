class Entry < ActiveRecord::Base
  belongs_to :user
  # default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 55 }
  validates :content, presence: true, length: { minimum: 200, maximum: 600 }

  has_attached_file :img, :styles => { :small  => "150x150#", :medium => "300x300#", :thumb => "100x100" }, :default_url => "/images/missing.png"
  validates_attachment :img,
  :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
  validates_attachment_size :img, :less_than => 2.megabytes

  def self.search(query)
    where("title like ? OR id like ?", "%#{query}%", "%#{query}%")
  end
end
