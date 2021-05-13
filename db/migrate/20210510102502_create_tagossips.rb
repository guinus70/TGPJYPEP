class CreateTagossips < ActiveRecord::Migration[6.1]
  def change
    create_table :tagossips do |t|
      t.belongs_to :gossip, index: true
      t.belongs_to :tag, index: true

      t.timestamps
    end
  end
end
