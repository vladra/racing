class Driver < Sequel::Model
  one_to_many(:laps) { |ds| ds.order(:number) }
  many_to_one :race
end
