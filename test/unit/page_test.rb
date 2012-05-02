require 'test_helper'

class PageTest < ActiveSupport::TestCase

  test 'Accepts valid attributes' do
    attributes = Page::Testing.valid_attributes
    page = Page.new(attributes)
    assert page.valid?
  end


  test 'Requires title' do
    attributes = Page::Testing.valid_attributes
    attributes.delete(:title)
    page = Page.new(attributes)
    assert !page.valid?, 'Page should require title attribute'
  end

  test 'Title cannot be empty' do
    attributes = Page::Testing.valid_attributes
    attributes[:title] = ''
    page = Page.new(attributes)
    assert !page.valid?, 'Page should require non-empty title attribute'
  end

  test 'Title cannot have spaces' do
    attributes = Page::Testing.valid_attributes
    attributes[:title] = 'Test Title'
    page = Page.new(attributes)
    assert !page.valid?, 'Page title should not allow spaces'
  end

  test 'Body_markup should be required' do
    attributes = Page::Testing.valid_attributes
    attributes.delete(:body_markup)
    page = Page.new(attributes)
    assert !page.valid?, 'Body should be required'
  end

  test 'Writing body_markup should set body_html' do
    attributes = Page::Testing.valid_attributes
    page = Page.new(attributes)
    assert page.body_html
    assert_equal Page::Testing.valid_body_html_attribute, page.body_html
  end

  test 'Body_markup should store value' do
    attributes = Page::Testing.valid_attributes
    page = Page.new(attributes)
    assert_equal attributes[:body_markup], page.body_markup
  end

end
