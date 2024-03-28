# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.time :published_at
      t.integer :author_id

      t.timestamps
    end
  end
end
