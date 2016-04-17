class AddPrivateToWiki < ActiveRecord::Migration
  def change
    change_column_default(:wikis, :private, false)
  end
end
