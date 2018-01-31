class Duration
  REGEX = /((?<hr>\d{2}):)?(?<min>\d{2}):(?<sec>\d{2})(\.|\,)(?<ms>\d{2}\d?)/

  def self.from_string(str, opts = {})
    m = str.match(REGEX)
    ms = m[:ms].length == 2 ? "#{m[:ms]}0" : m[:ms]
    new(hr: m[:hr], min: m[:min], sec: m[:sec], ms: ms)
  end

  def self.from_ms(ms)
    new(
      hr: ms / 1000 / 60 / 60 % 1,
      min: ms / 1000 / 60 % 60,
      sec: ms / 1000 % 60,
      ms: ms % 1000
    )
  end

  attr_reader :hr, :min, :sec, :ms

  def initialize(hr:, min:, sec:, ms:)
    @hr = hr.to_i
    @min = min.to_i
    @sec = sec.to_i
    @ms = ms.to_i
  end

  def total_ms
    hr_to_ms + min_to_ms + sec_to_ms + ms
  end

  def to_ms
    total_ms
  end

  def to_s
    "#{hr}:#{min}:#{sec}.#{ms}"
  end

  def inspect
    "<Duration hr:#{hr} min:#{min} sec:#{sec} ms:#{ms}>"
  end

  def +(other)
    self.class.from_ms(total_ms + other.total_ms)
  end

  def -(other)
    self.class.from_ms(total_ms - other.total_ms)
  end

  def >(other)
    total_ms > other.total_ms
  end

  def >=(other)
    total_ms >= other.total_ms
  end

  def <(other)
    total_ms < other.total_ms
  end

  def <=(other)
    total_ms <= other.total_ms
  end

  def ==(other)
    total_ms == other.total_ms
  end

  private

  def hr_to_ms
    hr * 60 * 60 * 1000
  end

  def min_to_ms
    min * 60 * 1000
  end

  def sec_to_ms
    sec * 1000
  end
end
