class Lap < Sequel::Model
  many_to_one :driver
end
