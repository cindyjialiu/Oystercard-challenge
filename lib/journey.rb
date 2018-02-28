class Journey
attr_accessor :list, :entry
  MINIMUM_FARE = 5
  def initialize
    @list = []
    @entry = nil
  end

  def add_entry(entry_station)
    @list << { entry: entry_station }
  end

  def add_exit(exit_station)
    if @list.last.length == 2
      @list << { exit: exit_station }
    else
      @list.last[:exit] = exit_station
    end
  end

  def in_journey?
    @value = @entry != nil
    @value
  end

  def fare
    p list
    if @list[-2][:entry] == nil
      return 11
    elsif @list.last[:entry] == nil
      return 6
    else
      return MINIMUM_FARE
    end
  end
end
