class AddTopicsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :f_name, null: false
      t.string :l_name, null: false
      t.string :email, null: false, unique: true
      t.string :password, null: false
      t.timestamps
    end

    create_table :categories do |t|
      t.string :name, null: false
      t.belongs_to :users, index: true
      t.timestamps
    end
  end
end
