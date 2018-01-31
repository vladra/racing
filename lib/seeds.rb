require_relative '../models'

def seed!
  race = Race.create(name: 'Крижаний Драйв')

  driver_1 = race.add_driver(name: 'Владимир Драло', number: '11', vehicle: 'Polaris RZR XP Turbo')
  driver_2 = race.add_driver(name: 'Владимир Барабаш', number: '81', vehicle: 'Polaris RZR XP Turbo')
  driver_3 = race.add_driver(name: 'Петр Лифшиц', number: '93', vehicle: 'Polaris RZR XP Turbo')

  driver_1.add_lap(number: 1, ms: Duration.from_string('00:12:31,79').to_ms)
  driver_1.add_lap(number: 2, ms: Duration.from_string('00:12:32,05').to_ms)
  driver_1.add_lap(number: 3, ms: Duration.from_string('00:11:27,95').to_ms)

  driver_2.add_lap(number: 1, ms: Duration.from_string('00:11:53,15').to_ms)
  driver_2.add_lap(number: 2, ms: Duration.from_string('00:11:50,58').to_ms)
  driver_2.add_lap(number: 3, ms: Duration.from_string('00:11:38,05').to_ms)
  driver_2.add_lap(number: 4, ms: Duration.from_string('00:11:24,30').to_ms)

  driver_3.add_lap(number: 1, ms: Duration.from_string('00:11:42,66').to_ms)
  driver_3.add_lap(number: 2, ms: Duration.from_string('00:11:21,07').to_ms)
  driver_3.add_lap(number: 3, ms: Duration.from_string('00:11:03,11').to_ms)
  driver_3.add_lap(number: 4, ms: Duration.from_string('00:11:58,76').to_ms)
end
