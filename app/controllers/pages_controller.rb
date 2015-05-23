class PagesController < ApplicationController

  def index
    @last_page = Paragraph.where(:main => true ).last.main_id.to_i
    
    @page = params['page'].to_i
    @prev_page = @page - 1 unless @page <= 1
    @next_page = @page + 1 unless @page >= @last_page
    @paragraphs = Paragraph.where( :main => true, :main_id => @page)
    
  end
  
  def new

    @page = Page.new

  end
  
 def create
    
   @page = Page.new
    
    respond_to do |format|
      if @page.save
        format.html { redirect_to root_path, notice: 'Page was successfully created.' }
        format.json { render :show, status: :created, location: @paragraph }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  

  
  def page_params
  params.require(:page).permit(:page_id, :chapter, :text)
  end
end
