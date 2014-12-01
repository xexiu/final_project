class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title
      t.text :content
      t.references :user, index: true

      t.timestamps
    end
    add_index :entries, [:user_id, :created_at]
  end
end
