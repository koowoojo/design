# 오늘의 3장 — 화면 설계

영유아 부모의 하루 마감용 사진 앱 시안. 요구사항 정의서(인터뷰 39턴, 2026-08-26)를 입력으로 했다.

**시안을 보려면** `prototype/index.html` 을 연다. 이 워크스페이스는 해당 HTML을 Cursor 내장 브라우저(`workbench.editor.browser`)로 연다. 소스 편집기가 뜨면 창을 한 번 다시 연 뒤 파일을 다시 클릭하거나, 파일에서 우클릭 → **Open in Integrated Browser** / **Show Preview** 를 쓴다.

---

## 무엇이 잠겨 있나

제품의 심장은 품질 점수가 아니라 **선택지를 줄여 하루를 닫는 것**이다.

- 첫 화면: 동등한 3장 + `오늘을 닫기`. 장면 5~7개는 접힘
- 성공: 아무것도 바꾸지 않고 확정
- 확정 직후 커머스 없음. 포토북은 월별 앨범에서만
- 점수·레이더·삭제·로그인 없음
- 시안 토큰은 **임의값** (브랜드 미정)

상세는 [`docs/ux-structure.md`](./docs/ux-structure.md), 화면 단위는 [`docs/screen-spec.md`](./docs/screen-spec.md).

---

## 폴더

| 경로 | 내용 |
|---|---|
| `docs/ux-structure.md` | 여정 2안, 시안 3안, 구조 잠금 |
| `docs/screen-spec.md` | 화면별 목적·위계·용어 |
| `docs/requirements.md` | 입력 요구사항 원문 |
| `prototype/index.html` | HTML/CSS 단일 파일 시안 |

원본은 위 마크다운과 `prototype/index.html` 이다. 생성물 폴더는 없다.

---

## 타깃 환경

크로스플랫폼 네이티브 (React Native 또는 Flutter). 시안 뷰포트는 iPhone 13 Pro 390×844. 웹/PWA로는 갤러리 쓰기가 불가하다고 요구사항에 적혀 있다.
