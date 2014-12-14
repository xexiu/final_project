class Entry < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  # default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 55 }
  validates :content, presence: true, length: { minimum: 55, maximum: 800 }

  has_attached_file :img, :styles => { :small  => "150x150#", :medium => "300x300#", :thumb => "100x100" }, :default_url => "/images/missing.png"
  validates_attachment :img,
  :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
  validates_attachment_size :img, :less_than => 2.megabytes

  def self.search(query)
    where("title like ? OR cast(id as text) like ?", "%#{query}%", "%#{query}%") unless Rails.env.production?
    else
    where("title like ? OR id like ?", "%#{query}%", "%#{query}%")
  end

end
