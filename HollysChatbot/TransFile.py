import sys

import io

sys.stdout = io.TextIOWrapper(sys.stdout.detach(), encoding = 'utf-8')

sys.stderr = io.TextIOWrapper(sys.stderr.detach(), encoding = 'utf-8')

import openpyxl



# 한 건의 대화에 대한 정보를 담는 객체

class Conversation:



    # 질문(Question), 응답(Answer) 두 변수로 구성

    def __init__(self, contentName, contentType, question, answer):

        self.contentName = contentName

        self.contentType = contentType

        self.question = question

        self.answer = answer + '\n더 궁금한 점이 있나요?'



    def __str__(self):

        return "질문: " + self.question + "\n답변: " + self.answer + "\n"



# 대화 데이터 담긴 엑셀 파일을 열기

wb = openpyxl.load_workbook(r'C:\Users\pc\Desktop\dialog\HollysMenu.xlsx')



# 활성 시트

ws = wb.active



conversations = []



# 시트 내에 존재하는 모든 데이터를 대화 객체 담음

for r in ws.rows:

    c = Conversation(r[0].value, r[1].value, r[2].value, r[3].value)

    conversations.append(c)



wb.close()



for c in conversations:

    print(str(c))



# 모든 대화 내용을 출력

for c in conversations:

    print(str(c))


# 출력 확인
print('총 ', len(conversations), '개의 대화가 존재합니다.')


# -*- coding: utf-8 -*-



# 파일로 출력하기 (오픈 소스)

i = 1

# 출력, 입력 값 JSON 파일을 생성

prev = str(conversations[0].contentName) + str(conversations[0].contentType)

f = open(prev + '.json', 'w', encoding='UTF-8')

f.write('{ "id": "10d3155d-4468-4118-8f5d-15009af446d0", "name": "' + prev + '", "auto": true, "contexts": [], "responses":
        [ { "resetContexts": false, "affectedContexts": [], "parameters": [], "messages": [ { "type": 0, "lang": "ko", "speech": "'
        + conversations[0].answer + '" } ], "defaultResponsePlatforms": {}, "speech": [] } ], "priority": 500000, "webhookUsed": false,
        "webhookForSlotFilling": false, "fallbackIntent": false, "events": [] }')

f.close()

f = open(prev + '_usersays_ko.json', 'w', encoding='UTF-8')

f.write("[")

f.write('{ "id": "3330d5a3-f38e-48fd-a3e6-000000000001", "data": [ { "text": "' + conversations[0].question
        + '", "userDefined": false } ], "isTemplate": false, "count": 0 },')



while True:

    if i >= len(conversations):

        f.write("]")

        f.close()

        break;

    c = conversations[i]

    if prev == str(c.contentName) + str(c.contentType):

        f.write('{ "id": "3330d5a3-f38e-48fd-a3e6-000000000001", "data": [ { "text": "' + c.question + '", "userDefined": false } ], "isTemplate": false, "count": 0 },')

    else:

        f.write("]")

        f.close()

        # 출력, 입력 값 JSON 파일을 생성

        prev = str(c.contentName) + str(c.contentType)

        f = open(prev + '.json', 'w', encoding='UTF-8')

        f.write('{ "id": "10d3155d-4468-4118-8f5d-15009af446d0", "name": "' + prev + '", "auto": true, "contexts": [], "responses": [ { "resetContexts": false, "affectedContexts": [],
         "parameters": [], "messages": [ { "type": 0, "lang": "ko", "speech": "' + c.answer + '" } ], "defaultResponsePlatforms": {}, "speech": [] } ], "priority": 500000, "webhookUsed": false,
          "webhookForSlotFilling": false, "fallbackIntent": false, "events": [] }')

        f.close()

        f = open(prev + '_usersays_ko.json', 'w', encoding='UTF-8')

        f.write("[")

        f.write('{ "id": "3330d5a3-f38e-48fd-a3e6-000000000001", "data": [ { "text": "' + c.question + '", "userDefined": false } ], "isTemplate": false, "count": 0 },')

    i = i + 1