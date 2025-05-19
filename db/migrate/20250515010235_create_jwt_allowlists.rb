
class CreateJwtAllowlist < ActiveRecord::Migration[8.0]
  def change
    create_table :jwt_allowlist do |t|
      t.string :jti, null: false
      t.references :user, null: false, foreign_key: true
      t.datetime :exp, null: false
      t.timestamps
    end

    add_index :jwt_allowlist, :jti, unique: true
  end
end
