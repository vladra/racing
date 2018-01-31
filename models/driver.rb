class Driver < Sequel::Model
  one_to_many :laps
  many_to_one :race
end
