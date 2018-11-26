class TestHelper < ApplicationHelper

  def initialize(browser)
    super
    @test_page = TestPage.new(@browser)
  end

  def helper_method
    # do things
  end

end
