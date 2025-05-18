from fastapi import FastAPI
from fastapi.responses import HTMLResponse
import database
import hashlib

item_data = {
    "stick_candy":350,
    "mychuu":1000,
    "drink":1300,
    "first_lunch_coupon":2000
}

#일방향 해쉬화 함수
def hash_password(password):
    password_bytes = password.encode('utf-8')
    hasher = hashlib.sha256()
    hasher.update(password_bytes)
    return hasher.hexdigest()

def verify_password(stored_hash, provided_password):
    hashed_provided_password = hash_password(provided_password)
    return stored_hash == hashed_provided_password

def data_update():
    with open("database.py", 'w', encoding='utf-8') as f:
        f.write(f"user_data = {data}")

app = FastAPI()
data = database.user_data

@app.get("/purchase/{item_name}/{id}/{password}/")
async def purchase(item_name:str,id:str,password:str):
    try:
        if id in data:
            verifying = verify_password(data[id]['password'],password)
            if verifying:
                if item_name in item_data:
                    if int(data[id]['point']) > int(item_data[item_name]):
                        data[id]["point"] -= item_data[item_name]
                        data_update()
                        try:
                            data[id]['item'][item_name] += 1
                        except:
                            data[id]['item'][item_name] = 1
                        data_update()
                        print(f"{id}가 {item_name}을 구매하였습니다.")
                        return True
                    else:
                        return "Point is not enough"
                else:
                    return "Item not found"

            else:
                return "verify failed"
        else:
            return "account not found"
    except:
        print("예기치 못한 오류가 발생하였습니다. -purchase")
        return "Something is wrong"

@app.get("/item_list/{id}")
async def item_list(id:str):
    try:
        if id in data:
            return data[id]['item']
        else:
            return "id is not found"
    except:
        print("예기치 못한 오류가 발생하였습니다. -Item_list")
        return "Something is wrong"

@app.get("/")
async def main():
    return "Welcome to Plogging"

@app.get("/devinfo",response_class=HTMLResponse)
async def definfo():
    html_devinfo="""
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>개발자 소개</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;  /* <-- 수정 */
            background: linear-gradient(135deg, #2b5876, #4e4376);
            font-family: 'Helvetica Neue', Arial, sans-serif;
            color: #fff;
            overflow: hidden;
            flex-direction: column;
        }
        .circle {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            animation: float 10s ease-in-out infinite;
        }
        .circle:nth-child(1) { width: 200px; height: 200px; top: 20%; left: 10%; animation-duration: 14s; }
        .circle:nth-child(2) { width: 120px; height: 120px; top: 60%; left: 80%; animation-duration: 12s; animation-delay: 3s; }
        .circle:nth-child(3) { width: 180px; height: 180px; top: 75%; left: 25%; animation-duration: 16s; animation-delay: 5s; }
        @keyframes float {
            0% { transform: translateY(0) scale(1); }
            50% { transform: translateY(-150px) scale(1.1); }
            100% { transform: translateY(0) scale(1); }
        }
        .wrapper {
            position: relative;
            z-index: 1;
            display: flex;
            gap: 40px;
            flex-wrap: wrap;
            justify-content: center;
            max-width: 1000px;
            padding: 40px;
        }
        .card {
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(10px);
            border-radius: 12px;
            padding: 20px 30px;
            width: 280px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            text-align: left;
        }
        .card h2 {
            font-size: 1.8rem;
            margin-bottom: 10px;
            color: #fff;
        }
        .card ul {
            list-style: none;
            margin-bottom: 15px;
        }
        .card ul li {
            margin-bottom: 6px;
            font-size: 1rem;
            color: #e0e0e0;
        }
        .github {
            display: inline-flex;
            align-items: center;  /* <-- 수정 */
            text-decoration: none;
            color: #fff;
            font-weight: bold;
            font-size: 1rem;
            margin-top: 10px;
        }
        .github svg {
            width: 20px;
            height: 20px;
            margin-right: 8px;
            fill: #fff;
        }
        .footer {
            position: relative;
            z-index: 1;
            margin-top: 30px;
            text-align: center;
            font-size: 0.9rem;
            color: rgba(255,255,255,0.7);
        }
        @media(max-width: 600px) {
            .wrapper { padding: 20px; gap: 20px; }
            .card { width: 100%; }
        }
    </style>
</head>
<body>
    <div class="circle"></div>
    <div class="circle"></div>
    <div class="circle"></div>
    <div class="wrapper">
        <div class="card">
            <h2>황규원</h2>
            <ul>
                <li><strong>소속:</strong> 신갈고등학교</li>
                <li><strong>학년:</strong> 1학년</li>
                <li><strong>전공:</strong> 백엔드(python) 개발</li>
            </ul>
            <a class="github" href="https://github.com/gyuwon09" target="_blank">
                <svg viewBox="0 0 16 16" aria-hidden="true">
                    <path d="M8 0C3.58 0 0 3.58 0 8a8 8 0 005.47 7.59c.4.07.55-.17.55-.38
                    0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13
                    -.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52
                    .28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12
                    0 0 .67-.21 2.2.82a7.7 7.7 0 012 0c1.53-1.03 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82
                    1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2
                    0 .21.15.46.55.38A8.01 8.01 0 0016 8c0-4.42-3.58-8-8-8z"/>
                </svg>
                gyuwon09
            </a>
        </div>
        <div class="card">
            <h2>이연우</h2>
            <ul>
                <li><strong>소속:</strong> 신갈고등학교</li>
                <li><strong>학년:</strong> 2학년</li>
                <li><strong>전공:</strong> 해킹</li>
            </ul>
            <a class="github" href="https://github.com/lee-yeon-woo" target="_blank">
                <svg viewBox="0 0 16 16" aria-hidden="true">
                    <path d="M8 0C3.58 0 0 3.58 0 8a8 8 0 005.47 7.59c.4.07.55-.17.55-.38
                    0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13
                    -.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52
                    .28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12
                    0 0 .67-.21 2.2.82a7.7 7.7 0 012 0c1.53-1.03 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82
                    1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2
                    0 .21.15.46.55.38A8.01 8.01 0 0016 8c0-4.42-3.58-8-8-8z"/>
                </svg>
                lee-yeon-woo
            </a>
        </div>
    </div>
    <div class="footer">
        <p>개발에 도움을 주신 강소희 선생님께 감사의 말씀 전합니다.<br>이 페이지는 2025.5에 작성되었습니다.</p>
    </div>
</body>
</html>


    """
    return html_devinfo

@app.get("/appinfo",response_class=HTMLResponse)
async def error():
    html_404 = """
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>404 Not Found</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    html, body { height: 100%; }
    body {
      display: flex;
      align-items: center;
      justify-content: center;
      font-family: 'Arial', sans-serif;
      background: linear-gradient(135deg, #335c8f 0%, #4a2c6b 100%);
      overflow: hidden;
      color: #fff;
    }
    .circle {
      position: absolute;
      border-radius: 50%;
      background: rgba(255, 255, 255, 0.1);
      animation: float 6s ease-in-out infinite;
    }
    .circle:nth-child(1) {
      width: 200px; height: 200px;
      top: 10%; left: 15%;
    }
    .circle:nth-child(2) {
      width: 300px; height: 300px;
      bottom: 20%; right: 10%;
      animation-duration: 8s;
    }
    .circle:nth-child(3) {
      width: 150px; height: 150px;
      bottom: 15%; left: 40%;
      animation-duration: 5s;
    }
    @keyframes float {
      0%, 100% { transform: translateY(0) scale(1); }
      50% { transform: translateY(-20px) scale(1.05); }
    }
    .card {
      position: relative;
      background: rgba(255, 255, 255, 0.1);
      backdrop-filter: blur(10px);
      border-radius: 16px;
      padding: 40px;
      text-align: center;
      max-width: 360px;
      box-shadow: 0 8px 32px rgba(0,0,0,0.3);

      /* --- 수정한 부분 --- */
      display: flex;
      flex-direction: column;
      justify-content: center;
      /* ----------------- */
    }
    .card h1 {
      font-size: 96px;
      margin-bottom: 16px;
      letter-spacing: 4px;
    }
    .card p {
      font-size: 18px;
      margin-bottom: 24px;
      line-height: 1.4;
    }
    .card a {
      display: inline-block;
      padding: 12px 24px;
      font-size: 16px;
      color: #fff;
      text-decoration: none;
      border: 2px solid #fff;
      border-radius: 8px;
      transition: background 0.3s, color 0.3s;
    }
    .card a:hover {
      background: #fff;
      color: #4a2c6b;
    }
  </style>
</head>
<body>
  <div class="circle"></div>
  <div class="circle"></div>
  <div class="circle"></div>
  <div class="card">
    <h1>404</h1>
    <p>죄송합니다. 찾으시는 페이지를 찾을 수 없습니다.</p>
  </div>
</body>
</html>

    """
    return html_404

@app.get("/privacy",response_class=HTMLResponse)
async def privacy_policy():
    policy_text = """
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>개인정보처리방침</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    html, body { height: 100%; }
    body {
      display: flex;
      justify-content: center;
      align-items: flex-start;
      padding: 40px;
      font-family: 'Arial', sans-serif;
      background: linear-gradient(135deg, #335c8f 0%, #4a2c6b 100%);
      background-attachment: fixed;
      color: #fff;
      overflow-x: hidden;
    }
    .circle {
      position: fixed;
      border-radius: 50%;
      background: rgba(255, 255, 255, 0.1);
      animation: float 6s ease-in-out infinite;
      pointer-events: none;
    }
    .circle:nth-child(1) { width: 180px; height: 180px; top: 10%; left: 10%; }
    .circle:nth-child(2) { width: 250px; height: 250px; bottom: 15%; right: 20%; animation-duration: 8s; }
    .circle:nth-child(3) { width: 140px; height: 140px; bottom: 10%; left: 45%; animation-duration: 5s; }
    @keyframes float {
      0%,100% { transform: translateY(0) scale(1); }
      50% { transform: translateY(-15px) scale(1.03); }
    }
    .card {
      position: relative;
      max-width: 800px;
      width: 100%;
      background: rgba(255,255,255,0.1);
      backdrop-filter: blur(12px);
      border-radius: 16px;
      padding: 40px;
      box-shadow: 0 8px 32px rgba(0,0,0,0.3);
      z-index: 1;
    }
    .card h1 {
      text-align: center;
      font-size: 36px;
      margin-bottom: 24px;
      border-bottom: 2px solid rgba(255,255,255,0.3);
      padding-bottom: 12px;
    }
    .card h2 {
      font-size: 24px;
      margin-top: 32px;
      margin-bottom: 16px;
      border-bottom: 1px solid rgba(255,255,255,0.2);
      padding-bottom: 8px;
    }
    .card p, .card ul {
      font-size: 16px;
      line-height: 1.6;
      margin-bottom: 16px;
      color: #f0f0f0;
    }
    .card ul { list-style: disc; margin-left: 20px; }
    .card strong { color: #fff; }
    .card .note {
      font-size: 14px;
      color: rgba(255,255,255,0.7);
      margin-top: -8px;
      margin-bottom: 16px;
    }
  </style>
</head>
<body>
  <div class="circle"></div>
  <div class="circle"></div>
  <div class="circle"></div>
  <div class="card">
    <h1>개인정보처리방침</h1>
    <p>시행일자: <strong>2025년 5월 17일</strong></p>
    <p>본 플로깅 앱(이하 "앱")은 개인정보 보호법 등 관련 법령에 따라 이용자의 개인정보를 보호하고, 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 아래와 같이 개인정보처리방침을 수립·공개합니다.</p>

    <h2>1. 수집하는 개인정보 항목</h2>
    <ul>
      <li><strong>(필수)</strong> 이메일, 닉네임, 로그인 기록</li>
      <li><strong>(선택)</strong> 프로필 사진</li>
      <li><strong>(자동 수집)</strong> 기기정보(기종, OS), 앱 이용기록, 플로깅 거리, 시간, 위치정보(GPS)</li>
    </ul>
    <p class="note">※ 위치 정보는 사용자의 동의를 받은 경우에만 수집됩니다.</p>

    <h2>2. 개인정보 수집 방법</h2>
    <ul>
      <li>회원가입 및 서비스 이용 시 사용자가 직접 입력</li>
      <li>서비스 이용 과정에서 자동 수집</li>
      <li>위치 정보는 사용자 동의 후 실시간 수집</li>
    </ul>

    <h2>3. 개인정보 이용 목적</h2>
    <ul>
      <li>회원 식별 및 관리</li>
      <li>플로깅 활동 기록 및 통계 제공</li>
      <li>도전과제, 랭킹 등 기능 제공</li>
      <li>서비스 개선 및 사용자 맞춤 콘텐츠 제공</li>
    </ul>

    <h2>4. 개인정보 보유 및 이용 기간</h2>
    <ul>
      <li>회원정보: 회원 탈퇴 시까지</li>
      <li>플로깅 기록: 서비스 이용 기간 동안 보관</li>
      <li>위치정보: 실시간 제공 후 즉시 폐기 또는 사용자의 요청 시 삭제</li>
    </ul>
    <p class="note">※ 관련 법령에 따라 일정 기간 보관이 필요한 경우 해당 법령을 따릅니다.</p>

    <h2>5. 개인정보 제3자 제공</h2>
    <p>앱은 이용자의 개인정보를 제3자에게 제공하지 않습니다. 단, 아래의 경우는 예외입니다.</p>
    <ul>
      <li>이용자가 사전에 동의한 경우</li>
      <li>법령에 의해 요구되는 경우</li>
    </ul>

    <h2>6. 개인정보 처리 위탁</h2>
    <p>앱은 원활한 서비스 제공을 위해 일부 업무를 외부에 위탁할 수 있으며, 위탁 시 관련 사항은 사전에 고지합니다.</p>

    <h2>7. 이용자의 권리 및 행사 방법</h2>
    <ul>
      <li>개인정보 열람, 수정, 삭제 요청 가능</li>
      <li>위치정보 제공 동의 철회 가능</li>
      <li>앱 내 [설정 > 개인정보 관리] 또는 고객센터를 통해 요청 가능</li>
    </ul>

    <h2>8. 개인정보 보호를 위한 조치</h2>
    <ul>
      <li>개인정보 암호화 저장</li>
      <li>접근 권한 최소화 및 관리</li>
      <li>보안 솔루션을 통한 외부 공격 차단</li>
    </ul>

    <h2>9. 개인정보 보호책임자</h2>
    <ul>
      <li><strong>성명:</strong>이연우</li>
      <li><strong>이메일:</strong> (이메일 주소)</li>
      <li><strong>문의:</strong>신갈고등학교 교무실</li>
    </ul>

    <h2>10. 개인정보처리방침 변경 안내</h2>
    <p>본 개인정보처리방침은 관련 법령 또는 내부 정책 변경에 따라 수정될 수 있으며, 변경 시 앱 내 공지사항을 통해 안내드립니다.</p>
  </div>
</body>
</html>

"""
    return policy_text


@app.get("/register/{user_name}/{user_password}/{user_tag}")
async def name(user_name:str,user_password:str,user_tag:str):
    try:
        if not user_name in data:
            hashed_password = hash_password(user_password)
            user_info = {
                "password": hashed_password,
                "user_tag": user_tag,
                "point" : 0,
                "item" : {
                    "stick_candy": 0,
                    "mychuu": 0,
                    "drink": 0,
                    "meals_coupon": 0
                }
            }
            data[user_name] = user_info
            data_update()
            return True
        else:
            return "Already exist"
    except:
        print("예기치 못한 오류가 발생했습니다. -회원가입")
        return "Error"

@app.get("/login/{user_name}/{user_password}")
async def name(user_name:str,user_password:str):
    if user_name in data:
        if verify_password(stored_hash=data[user_name]["password"],provided_password=user_password):
            data_update()
            return True, data[user_name]
        else:
            return False
    else:
        return False
