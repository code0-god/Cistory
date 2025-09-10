# Git & SSH 설정 가이드

## 1. Git 기본 설정

### 1.1. 사용자 정보 설정 (Global)

각 사용자는 자신의 계정에 로그인한 상태에서 다음 명령어를 한 번만 실행하여 Git 사용자 이름과 이메일을 설정합니다. GitHub/GitLab 계정과 일치시키는 것이 좋습니다.

```bash
# 사용자 이름과 이메일 지정
git config --global user.name "홍길동"
git config --global user.email "honggildong@example.com"

# 설정 확인
git config --global --list
```

### 1.2. 권장 추가 설정

다음 설정들은 필수는 아니지만, 사용의 편의성을 위해 모든 계정에 설정해두는 것을 권장합니다.

```bash
# 기본 브랜치 이름을 'main'으로 설정
git config --global init.defaultBranch main

# 터미널 출력에 색상 적용
git config --global color.ui auto
```

---

## 2. GitHub SSH 키 설정

SSH 키를 사용하면 비밀번호 없이 안전하게 GitHub와 통신할 수 있습니다.

### 2.1. (선택) 기존 SSH 키 확인

먼저, 이미 생성된 SSH 키가 있는지 확인합니다.

```bash
ls -al ~/.ssh
```

`id_rsa.pub` 또는 `id_ed25519.pub`와 같은 파일이 보인다면, 기존 키를 계속 사용해도 무방합니다. 키가 없다면 다음 단계로 진행하세요.

### 2.2. 새 SSH 키 생성

서버 터미널에서 아래 명령어를 입력하여 새로운 SSH 키를 생성합니다. 이메일은 본인의 GitHub 이메일로 변경해주세요.

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

- **Enter file in which to save the key...**: 기본 경로에 저장하려면 그냥 Enter를 누릅니다.
- **Enter passphrase...**: 키에 대한 비밀번호를 설정하는 단계입니다. 설정하지 않으려면 Enter를 두 번 누릅니다.

### 2.3. 공개키 복사

아래 명령어로 생성된 공개키의 내용을 확인하고, 출력되는 텍스트 전체를 복사합니다. (`ssh-ed25519`로 시작해서 이메일 주소로 끝나는 한 줄입니다.)

```bash
cat ~/.ssh/id_ed25519.pub
```

### 2.4. GitHub 계정에 공개키 등록

1.  GitHub 웹사이트에 로그인합니다.
2.  우측 상단 프로필 아이콘을 클릭하여 **Settings**로 이동합니다.
3.  왼쪽 메뉴에서 **SSH and GPG keys**를 클릭합니다.
4.  **New SSH key** 버튼을 누릅니다.
5.  **Title**에는 이 키를 식별할 수 있는 이름(예: `my-vps-server`)을 입력합니다.
6.  **Key** 입력란에 2.3 단계에서 복사한 공개키 전체를 붙여넣습니다.
7.  **Add SSH key** 버튼을 눌러 등록을 완료합니다.

### 2.5. 연결 테스트

모든 설정이 완료되었습니다. 아래와 같이 `git clone` 명령어를 실행하여 SSH 연결이 정상적으로 동작하는지 테스트합니다.

```bash
git clone git@github.com:username/repository.git
```

처음 연결 시 호스트의 신뢰성을 묻는 메시지가 나타날 수 있습니다. `yes`를 입력하고 진행하면 됩니다.
