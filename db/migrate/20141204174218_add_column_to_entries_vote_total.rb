class AddColumnToEntriesVoteTotal < ActiveRecord::Migration
  def change
    add_column :entries, :vote_total, :integer, default: 0
  end
end
