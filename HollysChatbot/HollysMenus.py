import sys

import io

sys.stdout = io.TextIOWrapper(sys.stdout.detach(), encoding = 'utf-8')

sys.stderr = io.TextIOWrapper(sys.stderr.detach(), encoding = 'utf-8')


import requests
from bs4 import BeautifulSoup

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
#print(allhrefName) #함수 시행(확인 위함)

#모든 메뉴 이름을 추출하는 함수
def get_menuNames():
    #메뉴와 상세정보를 담을 배열
    menuNames = [] #메뉴이름 담은 리스트

    for href in allhrefName:
        req = requests.get('http://www.hollys.co.kr'+href)
        html = req.text
        soup = BeautifulSoup(html, 'html.parser')

        divs = soup.find_all('div', {"class":"content"})
        for div in divs:
            #메뉴 이름이 존재하는 div 태그를 추출
            links = div.find_all('div',{"class":"tableType01"})

            # div 태그의 caption(메뉴이름) 태그를 추출
            for link in links:
                captions = link.find_all('caption') #메뉴이름들

                #caption내부의 텍스트를 리스트에 삽입
                for caption in captions:
                    menuName = caption.text
                    #print(menuName) #엑셀 내 메뉴명 복사를 위해 한 행씩 출력
                    menuNames.append(menuName) #추출된 caption(메뉴이름)내부텍스트를 menuNames 배열에 담음
        #print(menuNames)
    return menuNames

menuNamesF = get_menuNames()
#print(menuNamesF) #모든 메뉴 질문에 대한 답변을 위한 문자열 출력


#모든 메뉴 이름과 상세정보를 추출하는 함수
def get_menuDetails():
    #메뉴와 상세정보를 담을 배열
    menuDetails = [] #상세정보 배열
    menuNames = [] #메뉴이름 배열

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
                    #print(menuName)
                    menuNames.append(menuName) #추출된 caption(메뉴이름)내부텍스트를 menuNames 배열에 담음
                    for tr in trs:
                        attribute = tr.text.replace("\n","#")
                        menuDetails.append(attribute) #추출된 tr(주요성분)내부텍스트를 menuNames 배열에 담음
                        menuNames.extend(menuDetails)
                        menuDetails.clear()
                #print(menuNames)
                if len(menuNames) == 4:
                    print('메뉴: ' + menuNames[0]
                        +' 성분:'+'[칼로리:' + '(' + menuNames[2].split('#')[1]+')' + menuNames[2].split('#')[2] + ' (' + menuNames[3].split('#')[1]+')' + menuNames[3].split('#')[2]
                                +' 당류:' + '(' + menuNames[2].split('#')[1]+')' + menuNames[2].split('#')[3] + ' (' + menuNames[3].split('#')[1]+')' + menuNames[3].split('#')[3]
                                +' 단백질:' + '(' + menuNames[2].split('#')[1]+')' + menuNames[2].split('#')[4] + ' (' + menuNames[3].split('#')[1]+')' + menuNames[3].split('#')[4]
                                +' 포화지방:' + '(' + menuNames[2].split('#')[1]+')' + menuNames[2].split('#')[5] + ' (' + menuNames[3].split('#')[1]+')' + menuNames[3].split('#')[5]
                                +' 나트륨:' + '(' + menuNames[2].split('#')[1]+')' + menuNames[2].split('#')[6] + ' (' + menuNames[3].split('#')[1]+')' + menuNames[3].split('#')[6]
                                +' 카페인:' + '(' + menuNames[2].split('#')[1]+')' + menuNames[2].split('#')[7] + ' (' + menuNames[3].split('#')[1]+')' + menuNames[3].split('#')[7]+']'
                                )

                elif len(menuNames) == 3:
                    if '카페인' in menuNames[1]:
                        print('메뉴: ' + menuNames[0]
                            +' 성분:'+'[칼로리:' + '(' + menuNames[2].split('#')[1]+')' + menuNames[2].split('#')[2]
                                    +' 당류:' + '(' + menuNames[2].split('#')[1]+')' + menuNames[2].split('#')[3]
                                    +' 단백질:' + '(' + menuNames[2].split('#')[1]+')' + menuNames[2].split('#')[4]
                                    +' 포화지방:' + '(' + menuNames[2].split('#')[1]+')' + menuNames[2].split('#')[5]
                                    +' 나트륨:' + '(' + menuNames[2].split('#')[1]+')' + menuNames[2].split('#')[6]
                                    +' 카페인:' + '(' + menuNames[2].split('#')[1]+')' + menuNames[2].split('#')[7] + ']'
                                    )

                    else:
                        print('메뉴: ' + menuNames[0]
                            +' 성분:'+'[칼로리:' + menuNames[2].split('#')[1]
                                    +' 당류:' + menuNames[2].split('#')[2]
                                    +' 단백질:' +  menuNames[2].split('#')[3]
                                    +' 포화지방:' + menuNames[2].split('#')[4]
                                    +' 나트륨:' + menuNames[2].split('#')[5] + ']'
                                    )

                menuNames.clear()
    return menuNames

menuDetailsF = get_menuDetails()
#print(menuDetailsF) #get_menuNames() 함수 시행 및 출력(확인 위함)
