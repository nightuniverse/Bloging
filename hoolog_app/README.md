# Hoolog Flutter App

웹사이트를 Flutter 앱으로 변환한 개인 블로그 애플리케이션입니다.

## 기능

- 📝 블로그 포스트 작성 및 저장
- 📅 날짜별 포스트 필터링
- 🔄 실시간 데이터 동기화 (Firebase)
- 🗑️ 포스트 삭제 기능
- 📱 반응형 UI 디자인
- 🇰🇷 한국어 지원

## 기술 스택

- **Flutter** - 크로스 플랫폼 앱 개발
- **Firebase Firestore** - 실시간 데이터베이스
- **Material Design** - UI 컴포넌트

## 설치 및 실행

### 1. Flutter SDK 설치

Flutter SDK가 설치되어 있지 않다면 [Flutter 공식 사이트](https://flutter.dev/docs/get-started/install)에서 설치하세요.

### 2. 의존성 설치

```bash
cd hoolog_app
flutter pub get
```

### 3. Firebase 설정

1. Firebase Console에서 프로젝트를 생성하거나 기존 프로젝트를 사용
2. Firestore Database를 활성화
3. 보안 규칙을 설정 (테스트 모드로 시작 가능)

### 4. 앱 실행

```bash
# Android
flutter run

# iOS (macOS에서만)
flutter run -d ios

# 웹
flutter run -d chrome
```

## 프로젝트 구조

```
lib/
├── main.dart                 # 앱 진입점
├── firebase_options.dart     # Firebase 설정
├── models/
│   └── post.dart            # 포스트 모델
├── services/
│   └── firebase_service.dart # Firebase 서비스
├── screens/
│   └── home_screen.dart     # 메인 화면
└── widgets/
    ├── post_card.dart       # 포스트 카드 위젯
    └── add_post_form.dart   # 포스트 추가 폼
```

## 주요 기능 설명

### 포스트 작성
- 날짜 선택기로 원하는 날짜 선택
- 텍스트 입력으로 포스트 내용 작성
- 실시간으로 Firebase에 저장

### 포스트 관리
- 날짜별로 그룹화된 포스트 목록
- 전체 포스트 보기 및 특정 날짜 필터링
- 길게 눌러서 포스트 삭제

### 실시간 동기화
- Firebase Firestore의 실시간 리스너 사용
- 다른 기기에서 작성한 포스트도 즉시 반영

## 커스터마이징

### 색상 테마 변경
`lib/main.dart`의 `ThemeData`에서 색상을 수정할 수 있습니다.

### Firebase 설정 변경
`lib/firebase_options.dart`에서 Firebase 프로젝트 설정을 변경하세요.

## 문제 해결

### 빌드 오류
```bash
flutter clean
flutter pub get
flutter run
```

### Firebase 연결 오류
1. Firebase Console에서 프로젝트 설정 확인
2. Firestore Database가 활성화되어 있는지 확인
3. 보안 규칙 설정 확인

## 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다. 