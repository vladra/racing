class App
  route 'api' do |r|
    r.get 'races', Integer do |id|
      race = Race.with_laps(id)

      h = race.to_hash
      race.drivers.each do |driver|
        h[:drivers] ||= []

        driver_hash = driver.to_hash

        driver.laps.each do |lap|
          driver_hash[:laps] ||= []

          lap_hash = lap.to_hash.merge(str: Duration.from_ms(lap.ms).to_s)
          driver_hash[:laps] << lap_hash
        end

        driver_hash[:total_ms] = driver.laps.sum(&:ms)

        h[:drivers] << driver_hash
      end

      h.to_json
    end
  end
end
