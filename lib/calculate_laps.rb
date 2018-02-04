class CalculateLaps
  attr_reader :hash

  def initialize(race)
    @race = race
    @drivers = race.drivers
    @laps = race.drivers.map(&:laps).flatten
    @max_laps = @laps.map(&:number).max

    drivers_hash = @drivers.map do |d|
      laps = @max_laps.times.map do |i|
        number = i + 1
        d.laps.find { |l| l.number == i + 1 } || null_lap(number, d)
      end
      d.to_hash.merge(
        laps: laps.map(&:to_hash),
        total_ms: d.laps.map(&:ms).sum,
        total_laps: d.laps.count { |l| l[:ms] }
      )
    end
    @hash = @race.to_hash.merge(drivers: drivers_hash)
  end

  def call
    add_cumulative_laps
    add_gaps
    add_cumulative_gaps
    @hash
  end

  def add_cumulative_laps
    @hash[:drivers].each do |driver|
      skip = false
      cumulative = []

      (1..@max_laps).each do |number|
        lap = driver[:laps].find { |l| l[:number] == number }

        skip = true if null_lap?(lap)
        next if skip
        lap = lap.dup

        unless number == 1
          prev_lap = cumulative.find { |l| l[:number] == number - 1 }
          lap[:ms] += prev_lap[:ms]
        end
        cumulative << lap
      end

      driver[:cumulative_laps] = cumulative
    end
  end

  def add_gaps
    @hash[:drivers].each do |driver|
      gaps = []

      (1..@max_laps).each do |number|
        lap = driver[:laps].find { |l| l[:number] == number }

        next gaps << null_lap(number, driver) if null_lap?(lap)

        fastest = fastest_lap_time(number)
        lap = lap.dup
        lap[:ms] -= fastest
        gaps << lap
      end

      driver[:gaps] = gaps
    end
  end

  def add_cumulative_gaps
    @hash[:drivers].each do |driver|
      skip = false
      cumulative = []

      (1..@max_laps).each do |number|
        lap = driver[:cumulative_laps].find { |l| l[:number] == number }

        skip = true if null_lap?(lap)
        next if skip
        lap = lap.dup

        fastest = fastest_cumulative_lap(number)

        lap[:ms] -= fastest
        cumulative << lap
      end

      driver[:cumulative_gaps] = cumulative
    end
  end

  private

  def fastest_lap_time(number)
    @laps.select { |l| l.number == number }.map(&:ms).min
  end

  def fastest_cumulative_lap(number)
    @hash[:drivers]
      .map { |d| d[:cumulative_laps] }
      .flatten
      .select { |l| l[:number] == number }
      .map { |l| l[:ms] }
      .min
  end

  def null_lap(number, driver)
    { id: nil, number: number, ms: nil, driver_id: driver[:id] }
  end

  def null_lap?(lap)
    lap && lap[:ms] ? false : true
  end
end
