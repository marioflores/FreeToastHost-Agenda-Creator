require 'rubygems'
require 'mechanize'
require 'active_support/inflector'

class RosterData

  def initialize(roster)
    @currentRoster = roster
    @agent = Mechanize.new
    @currentAssignees = Hash.new
    self.set_http_request
    self.get_page
    self.get_roster_sections
    return @currentAssignees
  end
  
  def set_http_request
    self.set_credentials(@currentRoster.duty_roster['UserName'], @currentRoster.duty_roster['Password'])
    self.set_referer(@currentRoster.duty_roster['URL'], @currentRoster.duty_roster['Date'])
    self.set_url(@currentRoster.duty_roster['URL'], @currentRoster.duty_roster['Date'])
  end
  
  def set_credentials(username, password) 
    @agent.basic_auth(username, password)
  end
   
  def set_headers(url, date)
    @headers = {'referer' => url + date}
  end
   
  def set_url(url, date)
    @url = url + date
  end
  
  def set_referer(url, date)
    @referer = url + date
  end
  
  def get_page
    @page = @agent.get( @url, '', @referer )
  end
  
  def get_roster_sections
    self.get_header
    self.get_meeting_roster_roles
    self.get_officers_list
    self.get_additional_roles
  end
  
  def get_meeting_roster_roles
    @form = @page.form_with(:action => 'roster.cgi')
    @currentRoster.roles.each_pair { |key, value| @currentAssignees[key] = @form.field_with(:name => value).value.sub(".", " ").titleize }
  end
  
  def get_officers_list
    @officersList = Hash.new
    @currentRoster.officers_list.each_pair { |key, value| @currentAssignees[key] = value }
  end
  
  def get_header
    @officersList = Hash.new
    @currentRoster.header.each_pair { |key, value| @currentAssignees[key] = value }
  end
  
  def get_additional_roles
    @officersList = Hash.new
    @currentRoster.additional_roles.each_pair { |key, value| @currentAssignees[key] = self.get_officer_name(value) }
  end
  
  def get_officer_name(role)
    role_name = @currentRoster.officers_list[role]
    return role_name
  end  
  
  def show_current_assignees
    @currentAssignees.each_pair { |key, value| puts key, value }
  end
  
  def get_current_assignees
    return @currentAssignees
  end

end
