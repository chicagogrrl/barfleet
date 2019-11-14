# frozen_string_literal: true

class CreateRanks < ActiveRecord::Migration[6.0]
  def change
    create_table :ranks do |t|
      t.string :name
      t.string :abbreviation
      t.integer :sort_number

      t.timestamps
    end

    add_reference :memberships, :rank, index: true, null: true
    add_foreign_key :memberships, :ranks
  end
end
