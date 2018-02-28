class Journey
attr_accessor :list

  def initialize
    @list = []
  end

  def add(entry_station, exit_station)
    @list << { :entry_station => :exit_station }
  end

end
