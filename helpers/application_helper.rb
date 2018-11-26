class ApplicationHelper

  def initialize(browser)
    @browser = browser
    @global_nav_page = GlobalNavigationPage.new(@browser)
  end

  def login(email, password)
    @browser.goto('/login')
    @global_nav_page.email_text_field.set(email)
    @global_nav_page.password_text_field.set(password)
    @global_nav_page.login_button.click
  end

end
