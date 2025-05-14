import hashlib

def hash_password_simple(password):
    """
    암호를 SHA-256으로 간단하게 해싱합니다.
    (주의: 보안 강화를 위해 솔트 추가 및 반복 해싱 필요)
    """
    # 문자열 암호를 바이트로 인코딩해야 해싱 가능
    password_bytes = password.encode('utf-8')
    # SHA-256 해시 객체 생성
    hasher = hashlib.sha256()
    # 해시 값 업데이트
    hasher.update(password_bytes)
    # 16진수 문자열 형태로 반환
    return hasher.hexdigest()

def verify_password_simple(stored_hash, provided_password):
    """
    저장된 해시와 입력된 암호의 해시 값을 비교합니다.
    """
    # 입력된 암호를 해싱
    hashed_provided_password = hash_password_simple(provided_password)
    # 두 해시 값 비교
    return stored_hash == hashed_provided_password

## --- 사용 예시 ---
#my_password = "secure_password_123"
#
## 암호 해싱 (저장할 값 생성)
#hashed_for_storage = hash_password_simple(my_password)
#print(f"원본 암호: {my_password}")
#print(f"해싱된 값: {hashed_for_storage}")
#
#print("-" * 20)
#
## 암호 검증 (로그인 시 사용)
#input_password_correct = "secure_password_123"
#input_password_incorrect = "wrong_password"
#
#print(f"입력 암호 '{input_password_correct}' 검증 결과: {verify_password_simple(hashed_for_storage, input_password_correct)}") # True
#print(f"입력 암호 '{input_password_incorrect}' 검증 결과: {verify_password_simple(hashed_for_storage, input_password_incorrect)}") # False
