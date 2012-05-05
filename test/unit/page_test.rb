require 'test_helper'

class PageTest < ActiveSupport::TestCase

  test 'Accepts valid attributes' do
    page = pages(:todd)
    assert page.valid?
  end

  test 'Requires title' do
    page = pages(:todd)
    page.title = nil
    assert !page.valid?, 'Page should require title attribute'
  end

  test 'Title cannot be empty' do
    page = pages(:todd)
    page.title = ''
    assert !page.valid?, 'Page should require non-empty title attribute'
  end

  test 'Title cannot have spaces' do
    page = pages(:todd)
    page.title = 'Test Title'
    assert !page.valid?, 'Page title should not allow spaces'
  end

  test 'Body_markup should be required' do
    page = pages(:todd)
    page.body_markup = nil
    assert !page.valid?, 'Body should be required'
  end

  test 'Writing body_markup should set body_html' do
    page = pages(:todd)
    assert page.body_html # do we need this assertion?
    assert_equal "A very patient man indeed", page.body_html
  end

  test 'Body_markup should store value' do
    page = pages(:todd)
    assert_equal "=== NEATO! ===\nThis is a test page", page.body_markup
  end

end
