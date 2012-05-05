require 'wiki'

class Page < ActiveRecord::Base

  validates :title, :presence => true,
                    :format => {:without => /\s/,
                                :message => 'can not contain spaces'}

  validates :body_markup, :presence => true

  def self.[] title
    unless rv = find_by_title(title)
      error_message =  "Can't find page with title %s" % title
      raise ActiveRecord::RecordNotFound, error_message
    end
    return rv
  end

  def to_param
    return self.title
  end

  def body_markup= new_body
    write_attribute(:body_markup, new_body)
    wikify_body
  end

  def wikify_body
    html = Wiki.parse(body_markup)
    self.body_html = html
  end

end

