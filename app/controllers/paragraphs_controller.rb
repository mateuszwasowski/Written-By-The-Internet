class ParagraphsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_paragraph, only: [:show, :edit, :update, :destroy]

  # GET /paragraphs
  # GET /paragraphs.json
  def index
 
    @paragraphs = Paragraph.where(:main => nil).order('created_at DESC').paginate(:page => params[:page], :per_page => 1)
    
    @para_last = Paragraph.where(:main => true).last
  end

  # GET /paragraphs/1
  # GET /paragraphs/1.json  
  def show
     
  end

  # GET /paragraphs/new
  def new
    
   @para_last = Paragraph.where(:main => true).last
    @paragraph = Paragraph.new
    
  end

  # GET /paragraphs/1/edit
  def edit
    @paragraph = set_paragraph
    
    if current_user.id != @paragraph.user_id
      redirect_to :back
    end
  end

  # POST /paragraphs
  # POST /paragraphs.json
  def create
    
    @paragraph = Paragraph.new(paragraph_params)
    @paragraph.author = author
    @paragraph.user = current_user
    
    respond_to do |format|
      if @paragraph.save
        format.html { redirect_to vote_path, notice: 'Paragraph was successfully created.' }
        format.json { render :show, status: :created, location: @paragraph }
      else
        format.html { render :new }
        format.json { render json: @paragraph.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /paragraphs/1
  # PATCH/PUT /paragraphs/1.json
  def update
    
    @paragraph = set_paragraph
    @paragraph.votes.destroy_all
    
    if current_user.id != @paragraph.user_id
      redirect_to :back
    end
    respond_to do |format|
      if @paragraph.update(paragraph_params)
        format.html { redirect_to vote_path, notice: 'Paragraph was successfully updated.' }
        format.json { render :show, status: :ok, location: @paragraph }
      else
        format.html { render :edit }
        format.json { render json: @paragraph.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paragraphs/1
  # DELETE /paragraphs/1.json
  def destroy
    @paragraph.destroy
    respond_to do |format|
      format.html { redirect_to vote_path, notice: 'Paragraph was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def upvote

  @paragraph = set_paragraph
    if @paragraph.votes.where(:user_id => current_user.id).exists?  
      
      redirect_to :back
    else
      @paragraph.votes.create(:user_id => current_user.id)
      redirect_to :back
    end
  end
  
  def publish
    last_page = 0
    Paragraph.where(:main => true ).each do |para|  
      if para.main_id.to_i > last_page
        last_page = para.main_id
      end
    end
    @paragraph = set_paragraph
    @paragraph.main = true
    
    if if_enough?(@paragraph.parag.length, last_page) 
      @paragraph.main_id = last_page
    @paragraph.save
    else
      @paragraph.main_id = last_page.to_i + 1 
    @paragraph.save
    end
    
    Paragraph.where(:main_id => nil).destroy_all
    
    redirect_to :back
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    
    def author
      return "#{current_user.first_name} #{current_user.last_name}"
    end
  
  def if_enough?(this_para_length, last_page)
    temp = 0
    a = Paragraph.where(:main => true , :main_id => last_page)
    a.each do |paragraph|
      temp += paragraph.parag.length
    end
    
    if (temp + this_para_length) < 5000
      return true
    else
      return false
    end 
    
  end
  
  
    def set_paragraph
      @paragraph = Paragraph.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def paragraph_params
      params.require(:paragraph).permit(:author, :parag, :main, :main_id)
    end
end
