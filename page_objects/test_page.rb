class TestPage

  def initialize(browser)
    @browser = browser
  end

  def test_object
    @browser.text_field(id: 'test')
  end

end
