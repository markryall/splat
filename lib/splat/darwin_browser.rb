class String
  def to_browser
    @browser = Watir::Safari.new
    @browser.goto self
    @browser
  end
end