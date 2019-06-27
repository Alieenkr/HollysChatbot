#크롤링 이후 크롤링 자료 바탕 챗봇 구현은 시행 중
#크롤링 파일 json parse 코드 및 챗봇 구현 위한 코드는 최종보고서에 제출 예정

#한글 변환을 위한 import sys, io 관련 4문장 제외 모든 코드 직접 구현함

#외부코드--start
import sys

import io

sys.stdout = io.TextIOWrapper(sys.stdout.detach(), encoding = 'utf-8')

sys.stderr = io.TextIOWrapper(sys.stderr.detach(), encoding = 'utf-8')
#외부코드--end

import requests
from bs4 import BeautifulSoup

#메뉴와 상세정보를 담을 클래스
class Information:
    # 메뉴이름, 주요성분명, hot주요성분, ice주요성분 네 변수로 구성
    def __init__(self, menu, attribute, hot, ice):
        self.menu = menu
        self.attribute = attribute
        self.hot = hot
        self.ice = ice

    def __str__(self):
        return "메뉴이름:" + self.menu + "\n    " + self.attribute + "\n" + self.hot + "\n" + self.ice +"\n"


#메뉴를 추출할 페이지들의 링크를 추출하는 함수
def get_hrefNames():
    #링크들을 담을 배열
    hrefNames = []

    req = requests.get('http://www.hollys.co.kr/menu/newMenu.do')
    html = req.text
    soup = BeautifulSoup(html, 'html.parser')

    divs = soup.find_all('div', {"class":"lnb_wr"})
    for div in divs:
        #링크가 존재하는 ul 태그를 추출
        links = div.find_all('ul',{"class":"lnb"})

        # ul 태그의 a 태그를 추출
        for link in links:
            atags = link.find_all('a')

            #a 내부의 href를 리스트에 삽입
            for a in atags:
                hrefName = a.get('href')
                hrefNames.append(hrefName)

    return hrefNames

allhrefName = get_hrefNames()
print(allhrefName) #함수 시행(확인 위함)

#모든 메뉴 이름과 상세정보를 추출하는 함수
def get_menuNames():
    #메뉴와 상세정보를 담을 배열
    menuNames = []
    for href in allhrefName:
        req = requests.get('http://www.hollys.co.kr'+href)
        html = req.text
        soup = BeautifulSoup(html, 'html.parser')

        divs = soup.find_all('div', {"class":"content"})
        for div in divs:
            #메뉴 이름이 존재하는 div 태그를 추출
            links = div.find_all('div',{"class":"tableType01"})

            # div 태그의 caption(메뉴이름)과 tr(주요성분) 태그를 추출
            for link in links:
                captions = link.find_all('caption') #메뉴이름들
                trs = link.find_all('tr') #주요성분들

                #caption과 tr 내부의 텍스트를 리스트에 삽입
                for caption in captions:
                    menuName = caption.text
                    menuNames.append(menuName) #추출된 caption(메뉴이름)내부텍스트를 menuNames 배열에 담음
                    for tr in trs:
                        attribute = tr.text
                        menuNames.append(attribute) #추출된 tr(주요성분)내부텍스트를 menuNames 배열에 담음

    return menuNames

menuAttribute = get_menuNames()
print(menuAttribute) #get_menuNames() 함수 시행 및 출력(확인 위함)

#tr(주요성분)내의 텍스트를 의미있는 단위(주요성분명, hot주요성분, ice주요성분)로 분류하기 위한 작업
menuList = []
for detail in menuAttribute:
    if '칼로리' in detail:
        attribute = detail.replace("\n"," ")
    elif 'kcal' in detail:
        if 'HOT' in detail:
            hot = detail.replace("\n"," ")
        elif 'ICE' in detail:
            ice = detail.replace("\n"," ")
            info = Information(menu, attribute, hot, ice) #분류된 정보 정리 위해 Information클래스에 정리
            menuList.append(info)

    else: menu = detail.replace("\n","  ")

print('총', len(menuList), '개의 메뉴\n')

for c in menuList:
    print(str(c)) #분류된 값들을 단위별로 출력
