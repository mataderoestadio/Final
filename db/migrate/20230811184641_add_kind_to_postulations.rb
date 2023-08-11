class AddKindToPostulations < ActiveRecord::Migration[7.0]
  def change
    add_column :postulations, :kind, :string
  end
end
