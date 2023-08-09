class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :departamento
      t.string :cargo
      t.string :requerimientos
      t.string :sueldo

      t.timestamps
    end
  end
end
