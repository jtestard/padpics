class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.belongs_to :user
      t.string :remote_url
      t.timestamps
    end
  end
end
