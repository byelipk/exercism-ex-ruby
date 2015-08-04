require 'pry'

class Clock
  def self.at(hour, minute=0)
    GuarenteedClock.new(hour, minute)
  end
end

class GuarenteedClock
  attr_accessor :hours, :minutes

  def initialize(hours, minutes)
    @hours   = ClockTime.new(hours)
    @minutes = ClockTime.new(minutes, wrapper: MinutesWrapper.new)
  end

  def to_s
    "#{hours}:#{minutes}"
  end

  def + (time)
    AddTime.new(self, time).compute
  end

  def - (time)
    SubtractTime.new(self, time).compute
  end

  def ==(other)
    hours.value == other.hours.value && minutes.value == other.minutes.value
  end
end

class ClockTime
  attr_reader :value

  def initialize(value, wrapper: HoursWrapper.new)
    @value = wrapper.wrap(value)
  end

  def to_s
    buffer = ""
    buffer << 0.to_s if value < 10
    buffer << value.to_s
  end
end

class TimeManager

  attr_reader :clock, :time

  def initialize(clock, time)
    @clock = clock
    @time  = time
  end

  def compute
    raise NotImplementedError, "You must define this method in the subclass"
  end
end

class AddTime < TimeManager
  def compute
    hours   = time / 60
    minutes = time % 60

    clock.minutes  = ClockTime.new(clock.minutes.value + minutes, wrapper: MinutesWrapper.new)
    clock.hours    = ClockTime.new(clock.hours.value + hours)

    clock
  end
end

class SubtractTime < TimeManager
  def compute
    hours   = time / 60
    minutes = time % 60

    new_minutes = clock.minutes.value - minutes
    new_hours   = clock.hours.value - hours

    if new_hours < 0
      new_hours = 24 - new_hours.abs
    end
    
    if new_minutes < 0
      new_minutes = new_minutes.abs
      new_hours   = new_hours - 1
    end

    clock.minutes  = ClockTime.new(new_minutes, wrapper: MinutesWrapper.new)
    clock.hours    = ClockTime.new(new_hours)

    clock
  end
end

class HoursWrapper
  def wrap(value)
    value > 23 ? 0 : value
  end
end

class MinutesWrapper
  def wrap(value)
    value > 59 ? 0 : value
  end
end
