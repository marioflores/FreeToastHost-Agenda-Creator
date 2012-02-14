require 'rubygems'
require 'parseconfig'

class AgendaFormatter
  
  def initialize(config, roster)
    @roster = roster
    @configFile = ParseConfig.new(config)
    self.getGroups
  end
  
  def getSectionItems(group)
    section = Array.new
    @configFile.params[group].each_pair { |key,value| section[key.to_i] = parseValue(value)  }
    return section
  end
  
  def getValue(value)
    value = self.parseValue(value)
    return value
  end
  
  def parseValue(value)
    temp = value.split('|')
    
    if @roster.include?(temp[1]) then
      temp[1] = @roster[temp[1]]
    end
    
    
    return temp
  end
  
  def getGroups
    @groups = Hash.new
    @configFile.get_groups.each { |key| @groups[key] = self.getSectionItems(key) }
    return @groups
  end
  
end