class AddImageAndCapacityToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :image_field, :string, default: "logo1.png"
    add_column :events, :capacity, :integer, default: 1
  end
end
