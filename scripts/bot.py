# coding=utf-8 
from selenium import webdriver
from bs4 import BeautifulSoup
import json
import time
import warnings

class bot():
    warnings.filterwarnings('ignore')
    options = webdriver.ChromeOptions()
    options.add_argument('headless')
    options.add_argument('window-size=1920x1080')
    driver = webdriver.Chrome('./chromedriver', chrome_options=options)
    file =  open('settings.json', 'r')
    data = json.load(file)
    final_data = data['settings']
    GRID_CONTAINER_START = 1
    GRID_CONTAINER_FINAL = 8

    def site_login(self): 
        self.driver.get("https://siga.cps.sp.gov.br/aluno/login.aspx?") #pega a url do siga e passa pro driver
        time.sleep(2)
        try:
            self.driver.find_element_by_id("vSIS_USUARIOID").send_keys(self.final_data['username']) #pega as informações sobre o login
            self.driver.find_element_by_id("vSIS_USUARIOSENHA").send_keys(self.final_data['password']) #input de senha
            self.driver.find_element_by_name("BTCONFIRMA").click()
        except:
            print("Login failed")

    def find_page(self):
        time.sleep(2)
        self.driver.get("https://siga.cps.sp.gov.br/aluno/home.aspx") #acha o link de redirecionamento pra página das notas e clica
        self.driver.find_element_by_id("ygtvlabelel10").click()
        time.sleep(2)

    def parse_grades(self):
        time.sleep(2)
        self.driver.get("https://siga.cps.sp.gov.br/aluno/notasparciais.aspx")
        ##notas = driver.find_element_by_id("span_CTLACD_PLANOENSINOAVALIACAOPARCIALNOTA_000100040001")
        notas = self.driver.find_element_by_tag_name('tbody')
        html = notas.get_attribute("innerHTML")
        soup = BeautifulSoup(html, 'html.parser')
        dict = {}
        for i in range(self.GRID_CONTAINER_START, self.GRID_CONTAINER_FINAL):
            for grade in soup.find_all("tr", {"id": "Grid3ContainerRow_000"+str(i)}):
                cont = soup.find("table", {"id": "Grid2Container_000" +str(i) + "Tbl"})
                print(grade.text)
                for item in cont.find_all("tr", {"class": "tableborderOdd"}):
                    for subitem in item.find_all("span", {"class": "ReadonlyAttribute"}):
                        print(subitem.text)
                        #dict['id'] = i
                        #dict['id']['info'] = subitem.text
                print(i)
                print('\n')
                

        print(dict)
        self.driver.close()