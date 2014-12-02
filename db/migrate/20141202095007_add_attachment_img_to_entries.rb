class AddAttachmentImgToEntries < ActiveRecord::Migration
  def self.up
    change_table :entries do |t|
      t.attachment :img
    end
  end

  def self.down
    remove_attachment :entries, :img
  end
end
