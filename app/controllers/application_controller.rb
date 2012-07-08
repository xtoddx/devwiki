require 'fileutils'

class ApplicationController < ActionController::Base

  def fix_tag_uris page_data
    return page_data
  end
  
  def save_page_to_disk page_data
    debugger
    page_data = self.fix_tag_uris page_data
    base_dir = "public" + File.dirname(request.path)
    filename = @page.title + ".html"
    FileUtils.mkdir_p(base_dir)
    FileUtils.chdir(base_dir)
    File.open(filename, "w"){|f| f << page_data }
  end
  
  def delete_page_from_disk
  end

  protect_from_forgery
end
