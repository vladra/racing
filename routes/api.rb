require_relative '../lib/calculate_laps'

class App
  route 'api' do |r|
    r.on 'races' do
      # GET /api/races
      r.is do
        Race.reverse_order(:date).all.to_json
      end

      # GET /api/races/:id
      r.get Integer do |id|
        race = Race.with_laps(id)

        h = CalculateLaps.new(race).call

        h.to_json
      end
    end
  end
end
