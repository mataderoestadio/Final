class AddOnDeleteCascadeToPostulations < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :postulations, :jobs
    add_foreign_key :postulations, :jobs, on_delete: :cascade

    remove_foreign_key :postulations, :users
    add_foreign_key :postulations, :users, on_delete: :cascade
  end
end
