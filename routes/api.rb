require_relative '../lib/calculate_laps'

class App
  route 'api' do |r|
    r.get 'races', Integer do |id|
      race = Race.with_laps(id)

      h = CalculateLaps.new(race).call

      h.to_json
    end
  end
end
