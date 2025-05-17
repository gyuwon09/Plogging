from fastapi import FastAPI
import database
import hashlib

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

@app.get("/")
async def main():
    return "Welcome to Plogging"

@app.get("/register/{user_name}/{user_password}/{user_tag}")
async def name(user_name:str,user_password:str,user_tag:str):
    try:
        hashed_password = hash_password(user_password)
        user_info = {
            "password": hashed_password,
            "user_tag": user_tag,
            "pont" : 0
        }

        data[user_name] = user_info
        data_update()

        return True
    except:
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
