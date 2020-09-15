# coding=utf-8 
from selenium import webdriver
from bs4 import BeautifulSoup
import json
import time
import warnings

class Bot():
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

    def site_login(self, rg, password): 
        self.driver.get("https://siga.cps.sp.gov.br/aluno/login.aspx") #pega a url do siga e passa pro driver
        time.sleep(2)
        self.driver.find_element_by_id("vSIS_USUARIOID").send_keys(rg) #pega as informações sobre o login
        self.driver.find_element_by_id("vSIS_USUARIOSENHA").send_keys(password) #input de senha
        self.driver.find_element_by_name("BTCONFIRMA").click()
        try:
            self.find_page()
            return 0
        except:
            return 1

    def find_page(self):
        time.sleep(2)
        self.driver.get("https://siga.cps.sp.gov.br/aluno/home.aspx") #acha o link de redirecionamento pra página das notas e clica
        self.driver.find_element_by_id("ygtvlabelel10").click()
        time.sleep(2)
    
    def get_profile_data(self):
        div = self.driver.find_element_by_id("TABLE1_MPAGE")
        html = div.get_attribute("innerHTML")
        soup = BeautifulSoup(html, 'html.parser')
        imgtable = soup.find("td", {"style": "text-align:-khtml-center"})
        img = imgtable.find("img")
        spantable = soup.find("table", {"class": "Tb_CorpoCaixas"})
        span_nome = spantable.find("span", {"id": "span_MPW0041vPRO_PESSOALNOME"})
        dict = {
            'img': img['src'], 
            'nome': span_nome.text
        }
        print(dict)
        
    def parse_grades(self):
        time.sleep(2)
        self.driver.get("https://siga.cps.sp.gov.br/aluno/notasparciais.aspx")
        ##notas = driver.find_element_by_id("span_CTLACD_PLANOENSINOAVALIACAOPARCIALNOTA_000100040001")
        notas = self.driver.find_element_by_tag_name('tbody')
        html = notas.get_attribute("innerHTML")
        soup = BeautifulSoup(html, 'html.parser')
        list = []
        for i in range(self.GRID_CONTAINER_START, self.GRID_CONTAINER_FINAL):
            for grade in soup.find_all("tr", {"id": "Grid3ContainerRow_000"+str(i)}):
                cont = soup.find("table", {"id": "Grid2Container_000" +str(i) + "Tbl"})
                print(grade.text)
                for item in cont.find_all("tr", {"class": "tableborderOdd"}):
                    dict= {}
                    gradename = item.find("td", {"valign": "top"})
                    grade_number = item.find("td", {"valign": "middle"})
                    dict['id'] = str(i)
                    try:
                        dict['gradenumber'] = grade_number.text
                    except:
                        dict['gradenumber'] = "Sem Nota"
                    dict['grade'] = grade.text
                    dict['gradename'] = gradename.text
                    list.append(dict)
                print(i)
                print('\n')
        self.driver.close()
        return list
    
    def organize_grades(self, list):
        grade_list = []
        for item in list:
            grade_list.append(item['grade'])
        
        i = 1
        new_list = []
        for item in list:
            i =+ i
            if item['grade'] == grade_list[i]:
                dict = {}
                dict[grade_list[1]]= {
                    'notanome': item['gradename'],
                    'gradenumber': item['gradenumber']
                }
                new_list.append(dict)
        
        print(new_list)
    