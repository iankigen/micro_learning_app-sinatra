class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :f_name, null: false
      t.string :l_name, null: false
      t.string :email, null: false
      t.string :password, null: false
      t.timestamps
    end
  end
end
