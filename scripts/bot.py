# coding=utf-8 
from selenium import webdriver
from bs4 import BeautifulSoup
import json
import time
import warnings
import tools

class Bot():
    warnings.filterwarnings('ignore')
    options = webdriver.ChromeOptions()
    options.add_argument('headless')
    options.add_argument('window-size=1920x1080')
    driver = webdriver.Chrome('./chromedriver', chrome_options=options)
    GRID_CONTAINER_START = 1
    GRID_CONTAINER_FINAL = 8

    #método para logar no SIGA
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

    #método para teste (tenta achar uma página que só é possivel apos o LOGIN)
    def find_page(self):
        time.sleep(2)
        self.driver.get("https://siga.cps.sp.gov.br/aluno/home.aspx") #acha o link de redirecionamento pra página das notas e clica
        self.driver.find_element_by_id("ygtvlabelel10").click()
        time.sleep(2)
    
    #pega todos os dados, como IMAGEM, RA, PP e PR
    def get_profile_data(self):
        course_name = self.driver.find_element_by_id("span_vACD_CURSONOME_MPAGE").text
        period_time = self.driver.find_element_by_id("span_vACD_PERIODODESCRICAO_MPAGE").text
        div = self.driver.find_element_by_id("TABLE1_MPAGE")
        html = div.get_attribute("innerHTML")
        soup = BeautifulSoup(html, 'html.parser')
        imgtable = soup.find("td", {"style": "text-align:-khtml-center"})
        img = imgtable.find("img")
        spantable = soup.find("table", {"class": "Tb_CorpoCaixas"})
        span_nome = spantable.find("span", {"id": "span_MPW0041vPRO_PESSOALNOME"})
        span_ra = spantable.find("span",{"id": "span_MPW0041vACD_ALUNOCURSOREGISTROACADEMICOCURSO"})
        source = img['src'].replace('https:\\\\', 'https://')
        span_pp = spantable.find("span",{"id": "span_MPW0041vACD_ALUNOCURSOINDICEPP"})
        span_pr = spantable.find("span", {"id": "span_MPW0041vACD_ALUNOCURSOINDICEPR"})
        div_grades = soup.find("div", {"id": "ygtv21"})
        list = []
        for item in div_grades.find_all("span", {"class": "NodeTextDecoration"}):
            grade = item.text
            list.append(grade)

        span_nome_lower = span_nome.text.lower()
        span_nome_final = tools.capitalizeString(span_nome_lower)
        
        dict = {
            'img': source,
            'nome': span_nome_final,
            'ra': span_ra.text,
            'pp': span_pp.text,
            'pr': span_pr.text,
            'course' : course_name,
            'period': period_time,
        }
        
        i = 1
        for item in div_grades.find_all("span", {"class": "NodeTextDecoration"}):
            grade = item.text
            i = i  + 1
            update = {"grade" + str(i): grade}
            dict.update(update)

        return dict
        
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
                dict= {}
                for item in cont.find_all("tr", {"class": "tableborderOdd"}):
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

    #pega as faltas e presenças de cada aluno
    def absent(self):
        self.driver.get('https://siga.cps.sp.gov.br/aluno/faltasparciais.aspx')
        faltas = self.driver.find_element_by_id('Grid1ContainerTbl')
        html = faltas.get_attribute("innerHTML")
        soup = BeautifulSoup(html, 'html.parser')
        list = []
        for i in range(self.GRID_CONTAINER_START, self.GRID_CONTAINER_FINAL):
            for grade in soup.find_all("tr", {"id": "Grid1ContainerRow_000"+str(i)}):
                #print(grade.text)
                cont = grade.find("span", {"id": "span_vACD_DISCIPLINANOME_000" +str(i)})
                presence = grade.find("span", {"id":"span_vPRESENCAS_000" + str(i)})
                absence = grade.find("span", {"id":"span_vAUSENCIAS_000" + str(i)})
                dict = {
                    'id': str(i),
                    'grade': cont.text,
                    'presences': presence.text,
                    'absences': absence.text
                }
                list.append(dict)
            #print(i)
            #print('\n')    
        return list

    def parse_grades2(self):
        time.sleep(2)
        self.driver.get("https://siga.cps.sp.gov.br/aluno/notasparciais.aspx")
        ##notas = driver.find_element_by_id("span_CTLACD_PLANOENSINOAVALIACAOPARCIALNOTA_000100040001")
        notas = self.driver.find_element_by_tag_name('tbody')
        html = notas.get_attribute("innerHTML")
        soup = BeautifulSoup(html, 'html.parser')
        list = []
        for i in range(self.GRID_CONTAINER_START, self.GRID_CONTAINER_FINAL):
            dict = {}
            grade_name = soup.find("tr", {"id": "Grid3ContainerRow_000" + str(i)}).text
            dict['id'] = str(i)
            dict['grade_name'] = grade_name
            for table in soup.find_all("table", {"id": "Grid2Container_000" +str(i)+"Tbl"}):
                j=0
                for grade in table.find_all("tr", {"class": "tableborderOdd"}):
                    j = j  + 1
                    if 'Avaliacao' in grade.text:
                        newgrade = grade.text.replace('Avaliacao', '')  
                    update = {"grade" + str(j): newgrade}
                    dict.update(update)
            list.append(dict)
        
        return list
