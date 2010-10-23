class String
  def to_browser
    @browser = Watir::Browser.new
    @browser.goto self
    @browser
  end
end