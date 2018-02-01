require 'csv'

class ImportRaceCsv
  HEADERS = {
    '№ п/п'  => 'number',
    'ФИО'    => 'name'
  }.freeze

  attr_reader :rows

  def initialize(path)
    header_converters = lambda do |name|
      if name =~ /Круг/
        "lap_#{name.match(/\d{1,2}/) { |m| m[0] }}"
      else
        HEADERS[name]
      end
    end

    @rows = CSV.read(path, headers: true, header_converters: header_converters)
  end

  def call(name = '1')
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
