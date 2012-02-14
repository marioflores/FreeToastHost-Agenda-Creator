require 'rubygems'
require 'parseconfig'

class AgendaFormatter
  
  def initialize(config, roster)
    @roster = roster
    #puts @roster['PresidingOfficer']
    #puts @roster.inspect
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
    #puts value
    return value
  end
  
  def parseValue(value)
    temp = value.split('|')
    #puts @roster['PresidingOfficer']
    #puts temp[1]
    
    if @roster.include?(temp[1]) then
      temp[1] = @roster[temp[1]]
    end
    
    
    return temp
  end
  
  def getGroups
    @groups = Hash.new
    @configFile.get_groups.each { |key| @groups[key] = self.getSectionItems(key) }
    #@groups.each_pair { |key, value| puts key, value }
    return @groups
  end
  
end


#my_config = AgendaFormatter.new('/Users/saintflores/Temp/Workspace/AgendaCreator/src/template.config')
