class Race < Sequel::Model
  one_to_many :drivers

  dataset_module do
    def with_laps(id)
      eager(drivers: :laps).where(id: id).first
    end
  end
end
