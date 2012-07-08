class PagesController < ApplicationController
  after_filter :save_page_to_disk, :only => [:create, :update]
  append_after_filter :destroy_file_on_disk, :only => [:destroy]
  
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
        @page_html = render_to_string "show"
        debugger
    
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
        @page_html = render_to_string "show"
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

  def fix_page_uris page_html
    fixed_html = page_html
    target = 'href="/pages"'
    sub = 'href="' + request.url + '"'
    # TODO
    # - for links back to Edit or Destroy or other app behaviors put in
    #   the full URL instead of the full path
    # - for any images make sure we reference the static image location
    #
    return fixed_html
  end
  
  def save_page_to_disk
    html_data = self.fix_page_uris @page_html
    basedir = "public/pages/"
    filename = @page.title + ".html"
    FileUtils.mkdir_p(basedir)
    File.open(basedir + filename, "w"){|f| f << html_data}
    debugger
  end
    
  def destroy_file_on_disk
    basedir = "public/pages/"
    filename = @page.title + ".html"
    FileUtils.rm(basedir + filename)    
  end
end
