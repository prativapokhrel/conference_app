module SeleniumChrome
  module_function def setup_driver
    # Setup webdrivers install dir for codeship, because it finds a valid version provided by codeship it will not bother trying to reinstall one
    # NB: When we move from codeship we will need to update this
    if File.directory?('/home/rof/')
      Webdrivers.install_dir = '/home/rof/bin/'
    end

    # register base chrome driver
    Capybara.register_driver :chrome do |app|
      options = ::Selenium::WebDriver::Chrome::Options.new
      
      options.add_preference(:browser, set_download_behavior: { behavior: 'allow' })
      Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
    end

    # register headless chrome driver
    Capybara.register_driver :headless_chrome do |app|
      options = ::Selenium::WebDriver::Chrome::Options.new
      
      options.add_preference(:browser, set_download_behavior: { behavior: 'allow' })
      options.add_argument 'headless'
      options.add_argument 'disable-gpu'
      options.add_argument 'no-sandbox'
      options.add_argument 'disable-popup-blocking'
      options.add_argument 'window-size=2600x4000'
      options.add_argument 'lang=en_GB'
      Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
    end

    # add drivers to capybara-screenshot
    Capybara::Screenshot.register_driver(:chrome) do |driver, path|
      driver.browser.save_screenshot(path)
    end

    Capybara::Screenshot.register_driver(:headless_chrome) do |driver, path|
      driver.browser.save_screenshot(path)
    end
  end
end