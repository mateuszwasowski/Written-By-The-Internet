class PagesController < ApplicationController

  def index
    @last_page = Paragraph.where(:main => true ).last.main_id.to_i
    
    @page = params['page'].to_i
    @prev_page = @page - 1 unless @page <= 1
    @next_page = @page + 1 unless @page >= @last_page 
    
    if @next_page == nil
      @next_page = @last_page
    end
    
    @paragraphs = Paragraph.where( :main => true, :main_id => @page)
    
  end

  private
  
  def page_params
  params.require(:page).permit(:page_id, :chapter, :text)
  end
  
end
