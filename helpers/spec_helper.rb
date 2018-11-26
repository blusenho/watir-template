require 'watir'
require 'rspec'

Dir[File.join(File.dirname(__FILE__), '../page_objects', '*.rb')].each do |file|
  require_relative file
end

Dir[File.join(File.dirname(__FILE__), '../helpers', '*.rb')].each do |file|
  require_relative file
end

ENV['BROWSER'] = 'chrome' unless ENV['BROWSER']

RSpec.configure  do |config|
  config.tty = true
  config.filter_run :focus => true
  config.filter_run_excluding :ignore => true
  config.run_all_when_everything_filtered = true

  config.before(:all) do |x|

    if ENV['HEADLESS'] == 'true'
      @browser = Watir::Browser.new :chrome, args: ['--headless', '--disable-dev-shm-usage', '--no-sandbox']
    else
      @browser = Watir::Browser.new :chrome
    end
  end

  config.after(:each) do |example|
    if example.exception
      screenshot = "./test_results/screenshots/" + sanitize_filename("#{example.description}.png")
      @browser.screenshot.save(screenshot)
      scrape = "./test_results/html_scrapes/#{ENV['BUILD_TAG']}/" + sanitize_filename("#{example.description}.html")
      File.open(scrape, 'w+') {|file| file.write(@browser.html)}
    end
  end

  config.around(:each) do |example|
   Timeout::timeout(60) {
     example.run
   }
  end

  config.after(:all) do |example|
    @browser.close
  end

  private

  def sanitize_filename(filename)
    fn = filename.split /(?<=.)\.(?=[^.])(?!.*\.[^.])/m
    fn.map! { |s| s.gsub /[^a-z0-9\-]+/i, '_' }
    return fn.join '.'
  end

end
