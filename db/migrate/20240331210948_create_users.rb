class CreateUsers < ActiveRecord::Migration[7.1]
  def up
    create_table :users do |t|
      t.string :name
      t.timestamps
    end
    change_table :books do |t|
      t.references :user
    end
  end

  def down
    drop_table :users
    remove_column :books, :user_id
  end
end