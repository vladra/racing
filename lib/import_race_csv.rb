require 'csv'

class ImportRaceCsv
  HEADERS = {
    '№ п/п'  => 'number',
    'ФИО'    => 'name'
  }.freeze

  attr_reader :rows

  def initialize(path: nil, data: nil)
    raise ArgumentError unless path || data
    header_converters = lambda do |name|
      if name =~ /Круг/
        "lap_#{name.match(/\d{1,2}/) { |m| m[0] }}"
      else
        HEADERS[name]
      end
    end

    if path
      @rows = CSV.read(path, headers: true, header_converters: header_converters)
    else
      @rows = CSV.parse(data, headers: true, header_converters: header_converters)
    end
  end

  def call(name:, location:, date:)
    DB.transaction do
      race = Race.create(name: name)

      @rows.each do |row|
        name = row['name'].gsub("\"", '').strip
        driver = race.add_driver(name: name, number: row['number'])

        (1..20).each do |number|
          time = row["lap_#{number}"]
          next unless time
          ms = Duration.from_string(time).to_ms

          driver.add_lap(number: number, ms: ms)
        end
      end
    end
  end
end
