#Dir.chdir(File.dirname($PROGRAM_NAME))

require 'AgendaConfig'
require 'RosterData'
require 'AgendaFormatter'
require 'PDFCreator'

roster = AgendaConfig.new('/Users/saintflores/Temp/Workspace/AgendaCreator/src/roster.config')
my_roster = RosterData.new(roster)
my_roster = my_roster.get_current_assignees
#puts my_roster.inspect
#my_roster.each_pair { |key, value| puts key, value }
#puts my_roster.inspect
#my_roster.show_current_assignees
template = AgendaFormatter.new('/Users/saintflores/Temp/Workspace/AgendaCreator/src/template.config', my_roster)
template = template.getGroups
#puts template['Header']
pdf = PDFCreator.new(template)
pdf.create
