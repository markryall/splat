class String
  def to_browser
    @browser = Watir::IE.new
    @browser.goto self
    @browser
  end
end