from selenium.webdriver.firefox.options 
import Options as FirefoxOptions

options = FirefoxOptions()
options.add_argument("--headless")
driver = webdriver.Firefox(options=options)
driver.get("https://pythonbasics.org")