Sequel.migration do
  change do
    create_table :races do
      primary_key :id
      column :name, String, text: false, null: false
      column :location, String, text: false
      column :date, Date
    end

    create_table :drivers do
      primary_key :id
      column :name, String, text: false, null: false
      column :number, String, text: false, null: false
      column :vehicle, String, text: false, null: false
      foreign_key :race_id, :races, null: false, index: true
    end

    create_table :laps do
      primary_key :id
      column :ms, Integer, null: false
      column :time_string, String, null: false, text: false
      foreign_key :driver_id, :drivers, null: false, index: true
    end
  end
end
