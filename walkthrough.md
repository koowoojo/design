# Walkthrough — UX 키트 설정

시계열 작업 기록. 대상 저장소: `github.com/koowoojo/design` (Cloud Agent `bc-c2365595-4d59-4f89-b2a8-860f355b5756`).

## 2026-09-04 13:45 UTC — 첫 요청

사용자 요청: `c:\Users\amis5\AppData\Local\Temp\BNZ.6a9acb531527cb2d\SETUP-UX-KIT.md` 적용.

확인한 사실:
- 워크스페이스는 거의 비어 있음. `README.md` 한 줄(`# design`)과 git 초기 커밋(`babe9ab`)만 존재.
- 로컬 Windows 경로의 `SETUP-UX-KIT.md`는 이 Cloud Agent VM에서 읽히지 않음.
- GitHub `koowoojo/design` remote에도 해당 파일 없음. 브랜치는 `main`만 존재.
- 공개 웹/GitHub/npm에서 동일 파일명 `SETUP-UX-KIT.md`를 찾지 못함.
- Google Drive MCP는 인증 필요(`needsAuth`) 상태라 조회 불가.
- Bandizip 임시 폴더(`BNZ.<hash>`)에서 압축을 푼 문서로 보임.

적용은 보류. 원본 문서 내용 없이는 추측으로 키트를 만들지 않음.

## 2026-09-04 13:48 UTC — 재업로드 확인 요청

사용자 요청: 아래 세 파일을 다시 올렸으니 확인.

- `c:\Users\amis5\Downloads\fil333es\design.zip`
- `c:\Users\amis5\Downloads\fil333es\README.md`
- `c:\Users\amis5\Downloads\fil333es\SETUP-UX-KIT.md`

재확인 범위:
- `/workspace`, `/home/ubuntu`, `/tmp`, `/opt/cursor`, `/cursor/stores`, `/mnt`
- GitHub `koowoojo/design` fetch 및 contents API
- Cloud Agent 트랜스크립트 첨부 메타데이터
- 최근 60분 내 `*.md` / `*.zip` 생성 파일

결과:
- 세 파일 모두 이 환경에 없음.
- GitHub 저장소는 여전히 `README.md`만 있음.
- 대화 트랜스크립트에도 경로 문자열만 있고, 파일 blob/첨부 메타데이터는 없음.
- Windows 경로를 채팅에 붙여넣는 것만으로는 Cloud Agent로 파일이 전송되지 않음.

현재 차단 사유: 적용할 원본(`SETUP-UX-KIT.md`, `design.zip`, 로컬 `README.md`)이 VM/원격 저장소/첨부 어느 쪽에도 없음.

다음 턴에서 적용을 재개하려면 아래 중 하나가 필요함.
1. Cursor Cloud Agent 채팅의 첨부(클립) 버튼으로 실제 파일을 올리기
2. `SETUP-UX-KIT.md` / `README.md` 본문을 메시지에 붙여넣기
3. `github.com/koowoojo/design`에 파일을 푸시한 뒤 알려주기

## 2026-09-04 13:54 UTC — 사용자 선택 3번 + ㄱㄱ

사용자가 `ㄱㄱ` 와 `3` 을 입력. GitHub 푸시 경로로 재확인.

`git fetch origin main` 결과: 로컬이 origin/main 보다 1커밋 뒤처짐.
원격 트리에 아래가 추가됨.

- `README.md` (8바이트, 기존과 동일)
- `SETUP-UX-KIT.md` (23796바이트)
- `design.zip` (37722바이트)

`e64901b` 로 fast-forward. zip 내부는 업스트림 키트 소스(`ux-kit/src`, `build.sh`, `learnings`, `_TEMPLATE` 등).

## 2026-09-04 13:55 UTC — SETUP-UX-KIT 적용

브랜치: `cursor/apply-ux-kit-5756`

수행:
1. `design.zip` 을 풀어 이 레포에 업스트림 소스 복원 (`ux-kit/src`, `dist`, `build.sh`, `learnings`, `projects/_TEMPLATE`, 루트 README/.gitignore)
2. SETUP 1~4단계 실행
   - `.cursor/rules/ux-kit-entry.mdc` ← BLOCK A 그대로
   - `ux-kit/UX-UI-RULES.md` ← BLOCK B 그대로
   - `ux-kit/context.md` ← BLOCK C 그대로 (기존 파일 없음)
   - `ux-kit/projects/`, `ux-kit/learnings/` 준비. learnings 세 파일은 zip 원본이 있어 덮어쓰지 않음

5단계 검증 (실제 확인):
- entry 존재 / 첫 줄 `---` / `alwaysApply: true` 포함
- `ux-kit/UX-UI-RULES.md` 존재
- `ux-kit/context.md` 존재
- `ux-kit/projects/`, `ux-kit/learnings/` 존재
- 설치본 ↔ 소스 바이트 일치 (`entry.mdc`, `UX-UI-RULES.md`, `context.md` == `_template.md`)
- `ux-kit/build.sh` 종료 코드 0 — `✅ 생성 완료: dist/SETUP-UX-KIT.md (580 lines) / 진입점 24줄`

UX 화면 설계는 시작하지 않음. SETUP 지시대로 설치까지만 수행.

커밋: `742cad9` `feat(ux-kit): SETUP-UX-KIT 설치와 업스트림 소스 복원`
PR: https://github.com/koowoojo/design/pull/1 (ready for review)

재검증 (완료 직전):
- ENTRY_OK / BODY_OK / CONTEXT_OK / DIRS_OK
- 진입점 24줄
- `build.sh` BUILD_EXIT:0
- 워킹트리 클린

## 2026-09-04 14:00 UTC — main 병합 요청

사용자: "main으로 합쳐줘". finishing-a-development-branch 스킬 적용. 선택지는 이미 사용자가 지정함 (main 병합).

병합 전 재검증:
- ENTRY_OK / BODY_OK / CONTEXT_OK
- `build.sh` BUILD_EXIT:0
- PR #1 `MERGEABLE` / `CLEAN`
- CI 체크 없음 (문서·규칙 설치 PR)
- 베이스: `origin/main` (`e64901b`)

`gh pr merge`는 직후 GraphQL `not mergeable`로 실패. 로컬에서 `main`에 `--no-ff` 병합 후 `origin/main` 푸시.

결과:
- 병합 커밋: `4177200`
- PR #1 상태: `MERGED` (https://github.com/koowoojo/design/pull/1)
- 병합 후 `build.sh` BUILD_EXIT:0, ENTRY_OK
- 로컬 브랜치 `cursor/apply-ux-kit-5756` 삭제

---

# Walkthrough — 오늘의 3장 화면 설계

시계열 작업 기록. 브랜치 `cursor/today-three-screen-design-b96f`. PR https://github.com/koowoojo/design/pull/2

## 2026-09-04 14:00 UTC — 요청

사용자: 오늘의 3장 요구사항 정의서(인터뷰 39턴, 2026-08-26)를 붙여 넣고 "아래 기반으로 화면 설계해줘".

발동: UX-KIT 진입점. `ux-kit/UX-UI-RULES.md`와 `context.md`를 코드보다 먼저 읽음. context §1 환경 레퍼토리는 비어 있음.

클라우드 에이전트 제약(질문 없이 완수)과 UX-KIT(한 턴 한 질문, 승인 전 렌더 금지)가 충돌. 요구사항 §3·§5에 이미 있는 값(첫 화면, 네이티브, iPhone 13 Pro)은 재질문하지 않고 추출. 추천안을 잠금 **제안**으로 표시한 뒤 렌더.

## 2026-09-04 14:02 — 입력 추출 · 레퍼런스

추출:
- JTBD = 끝내기. 점수·삭제는 통증
- 첫 화면 = 3장 + 확정, 묶음 접힘
- 확정 직후 커머스 기각. 포토북은 월별 앨범만
- 타깃 = RN/Flutter, A15 10초, Apple Intelligence 금지

레퍼런스(고유명사 검색 없이):
- 하루 1장 일기형 Today 홈
- 하루 소량 배치 정리 (삭제는 반대로 배제)
- 모바일 아코디언 / progressive disclosure
- 완결 보상
- 먼 업계: 코스 요리(수락이 본업, 교체는 예외)

## 2026-09-04 14:05 — UX 2안 · 시안 3안

A안 코스 수락형(추천) / B안 후보 개방형.
시안 1안 동등 트립틱(추천) / 2안 2+1 카드 / 3안 겹친 코스 카드.
근거: 1안이 순위·점수 없이 접힘면에 닫기를 두고, 접힌 장면으로 통제감을 지킴.

문서:
- `todays-three/docs/ux-structure.md`
- `todays-three/docs/screen-spec.md`
- `todays-three/docs/requirements.md`

## 2026-09-04 14:08 — 시안 렌더 · 검증 전 커밋

`todays-three/prototype/index.html` 단일 파일. 390×844 폰 + 데스크톱 화면 목록.
커밋 `efaf091`. push. PR #2 draft 생성.

## 2026-09-04 14:09 — 브라우저 검증 1

`python3 -m http.server 8765 --directory todays-three/prototype`
computerUse로 본 경로 전수:
고지 1→2→3(체크 전 버튼 비활성 확인)→처리→오늘→장면 펼침→후보→자리 교체→오늘을 닫기→공유→앨범→포토북→오늘 탭이 봉인 유지.
빈 상태·권한 거부 좌측 점프.
금지 문구(점수/레이더/AI 추천/삭제) 없음.
확정 직후 포토북 없음.

처리 화면이 700ms×3이라 첫 패스에서 체감이 짧았음.
영상: `/opt/cursor/artifacts/todays_three_full_flow.mp4` (videoReview: 본 경로와 일치, 봉인 직후 커머스 없음).

발견된 문제:
1. 앨범 제목 "닫아 둔 날 12" vs 카드 4장
2. 닫힘 배지가 장면명과 겹침
3. 스펙의 앨범 ··· 개인정보 진입 누락 (스펙 이탈 1)
4. favicon 404

## 2026-09-04 14:25 — 수정 · 재검증

- 일수 4, 포토북 카피 12장(4×3) 유지
- 닫힘 배지 상단
- 앨범 ··· → 개인정보 시트
- 처리 1.1초×3
- favicon data URI

재검증 통과: 처리 화면 포착, 앨범 4, 개인정보 시트, 배지 비중첩, 봉인 후 커머스 없음.

스크린샷 아티팩트:
- screen_today_unconfirmed.webp
- screen_replace.webp
- screen_sealed.webp / screen_sealed_badge.webp
- screen_album.webp
- screen_processing.webp
- screen_privacy.webp

## 2026-09-04 14:30 — 키트 누적

`ux-kit/projects/2026-09-todays-three/` session-report + retro.
learnings: antipatterns(부가 진입 누락), patterns(더미 수량 일치). 발생 1회, 승격 없음.
context.md §1에 소비자 모바일 환경 1행 추가 (확인 상태: 추정).

세션 지표: 이탈 1 / 사용자 구조변경 0 / 회귀 0.

gh 이슈 생성은 이 환경에서 쓰기 금지라 폴백(본문 출력)으로 넘김.

## 2026-09-04 14:36 UTC — 다음 과정 질문

사용자: "이 다음 과정은?"

답한 순서:
1. 지금: UX-KIT [4] 게이트. `1` 구조 `2` 배치 `3` 톤 `4` 확정
2. `4`면 [6] 일관성 검사 → 화면 스펙 잠금
3. 그다음 코딩이 아님. 요구사항 §12의 킬러 가정 1순위 검증이 개발 착수 조건
4. 통과 후에야 원가 확인 → 빌드 프롬프트 → 네이티브 구현

시안·스펙 파일은 이 턴에서 변경하지 않음.

## 2026-09-04 14:38 UTC — HTML이 에디터로 열림

사용자: 시안 HTML이 커서 에디터로만 열린다. 내장 브라우저로 바로 보게 해 달라.

조치:
- `.vscode/settings.json` — `**/todays-three/prototype/*.html` → `workbench.editor.browser`
- localhost 링크는 내장 브라우저 (`workbench.browser.openLocalhostLinks`)
- `.vscode/launch.json` — F5로 `http://127.0.0.1:8765/` 를 editor-browser에 연다
- `.vscode/tasks.json` — 시안 정적 서버

폴백: 우클릭 Open in Integrated Browser / Show Preview. Agents(Glass) 파일 트리는 association을 무시할 수 있음.
