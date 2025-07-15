# Firebase 설정 가이드

## 1. Firebase 프로젝트 생성

1. [Firebase Console](https://console.firebase.google.com/)에 접속
2. "프로젝트 추가" 클릭
3. 프로젝트 이름 입력 (예: "hoolog-blog")
4. Google Analytics 설정 (선택사항)
5. "프로젝트 만들기" 클릭

## 2. Firestore 데이터베이스 설정

1. 왼쪽 메뉴에서 "Firestore Database" 클릭
2. "데이터베이스 만들기" 클릭
3. 보안 규칙 선택:
   - **테스트 모드에서 시작** (개발용)
   - 또는 **프로덕션 모드에서 시작** (보안 강화)
4. 데이터베이스 위치 선택 (가까운 지역 선택)

## 3. 웹 앱 등록

1. 프로젝트 개요 페이지에서 웹 아이콘(</>) 클릭
2. 앱 닉네임 입력 (예: "hoolog-web")
3. "앱 등록" 클릭
4. Firebase 구성 객체 복사

## 4. 코드에 Firebase 설정 추가

`index.html` 파일의 다음 부분을 실제 Firebase 설정으로 교체:

```javascript
const firebaseConfig = {
  apiKey: "실제_API_KEY",
  authDomain: "실제_PROJECT_ID.firebaseapp.com",
  projectId: "실제_PROJECT_ID",
  storageBucket: "실제_PROJECT_ID.appspot.com",
  messagingSenderId: "실제_MESSAGING_SENDER_ID",
  appId: "실제_APP_ID"
};
```

## 5. Firestore 보안 규칙 설정 (선택사항)

Firestore Database > 규칙 탭에서 다음 규칙 설정:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /posts/{document} {
      allow read, write: if true;  // 모든 사용자가 읽기/쓰기 가능
    }
  }
}
```

## 6. 배포

1. Vercel에 다시 배포
2. 이제 모든 기기에서 동일한 데이터를 볼 수 있습니다!

## 주의사항

- Firebase 무료 플랜은 월 50,000 읽기, 20,000 쓰기, 20,000 삭제를 제공합니다
- 개인 블로그 용도로는 충분합니다
- 데이터는 실시간으로 모든 기기에 동기화됩니다

## 문제 해결

- 브라우저 콘솔에서 오류 확인
- Firebase 설정이 올바른지 확인
- Firestore 데이터베이스가 생성되었는지 확인 