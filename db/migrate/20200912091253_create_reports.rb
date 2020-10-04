# frozen_string_literal: true

class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.text :body,    null: false
      t.string :title, null: false

      t.timestamps
    end
  end
end
