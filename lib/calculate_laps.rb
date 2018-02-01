class CalculateLaps
  attr_reader :hash

  def initialize(race)
    @race = race
    @drivers = race.drivers
    @laps = race.drivers.map(&:laps).flatten
    @max_laps = @laps.map(&:number).max

    drivers_hash = @drivers.map do |d|
      d.to_hash.merge(laps: d.laps.map(&:to_hash))
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

        skip = true unless lap
        next if skip
        lap = lap.dup

        if number == 1
          cumulative << lap
        else
          prev_lap = cumulative.find { |l| l[:number] == number - 1 }
          lap[:ms] += prev_lap[:ms]
          cumulative << lap
        end
      end

      driver[:cumulative_laps] = cumulative
    end
  end

  def add_gaps
    @hash[:drivers].each do |driver|
      gaps = []

      (1..@max_laps).each do |number|
        lap = driver[:laps].find { |l| l[:number] == number }

        next gaps << { id: nil, number: number, ms: nil, driver_id: driver[:id] } unless lap

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

        skip = true unless lap
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
end
