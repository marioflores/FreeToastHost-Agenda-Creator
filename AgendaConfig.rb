require 'rubygems'
require 'parseconfig'

class AgendaConfig
  
  def initialize(file)
    @configFile = ParseConfig.new(file)
  end
  
  def roles
    return @configFile.params['Roles']
  end
  
  def additional_roles
    return @configFile.params['AdditionalRoles']
  end
  
  def duty_roster
    return @configFile.params['DutyRoster']
  end
  
  def agenda
    return @configFile.params['Agenda']
  end  
  
  def officers_list
    return @configFile.params['OfficersList']
  end
  
  def officers_order
    return @configFile.params['OfficersOrder']
  end
  
  def header
    return @configFile.params['Header']
  end  
  
end
