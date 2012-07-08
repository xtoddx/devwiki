class PagesController < ApplicationController
  #after_filter :save_page_to_disk, :only => [:update, :create]
  
  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    @page = Page[params[:id]]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html do
        @page = Page.new(:title => params[:id])
        render action: 'edit', status: '404'
      end
      format.json { head :no_content, status: '404' }
    end  
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page[params[:id]]
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page = Page[params[:id]]

    respond_to do |format|
      if @page.update_attributes(params[:page])
        debugger
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page[params[:id]]
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end

  private
    def save_page_to_disk
      debugger
      one = 1
      #page_data = render_to_string "show"
      base_dir = "public" + File.dirname(request.path)
      #filename = @page.title + ".html"
      #FileUtils.mkdir_p(base_dir)
      #FileUtils.chdir(base_dir)
      #File.open(filename, "w"){|f| f << page_data }
    end
    
end
