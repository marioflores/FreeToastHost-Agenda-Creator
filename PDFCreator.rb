require 'rubygems'
require 'parseconfig'
require 'prawn'
require 'prawn/layout'

class PDFCreator
  
  def initialize(data)
    @agendaData = data
  end
 
  def create
    
    header = @agendaData["Header"].to_a
    agenda = @agendaData["Agenda"].to_a
    officers = @agendaData["OfficersOrder"].to_a
    
    Prawn::Document.generate("ToastmasterAgenda.pdf") do
          
    widths = {0 => 275, 1 => 125}
          
    table header,
      :position           => :center,
      :column_widths      => widths,
      :align_headers      => :left,
      :vertical_padding   => 2,
      :horizontal_padding => 2,
      :width              => 400,
      :border_style       => :grid,
      :border_width       => 0,
      :row_colors         => :pdf_writer
    
    text "\n\n"
          
    table agenda,
      :position           => :center,
      :column_widths      => widths,
      :align_headers      => :left,
      :vertical_padding   => 2,
      :horizontal_padding => 2,
      :width              => 400,
      :border_style       => :grid,
      :border_width       => 0,
      :row_colors         => :pdf_writer
    
    text "\n\n"
  
    table officers,
      :position           => :center,
      :column_widths      => widths,
      :align_headers      => :left,
      :vertical_padding   => 2,
      :horizontal_padding => 2,
      :width              => 400,
      :border_style       => :grid,
      :border_width       => 0,
      :row_colors         => :pdf_writer

    text "\n"
    
    end
    
  end

end