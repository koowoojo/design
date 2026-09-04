#!/usr/bin/env bash
# dist/SETUP-UX-KIT.md 를 src/ 원본에서 생성한다.
# dist/ 는 절대 직접 수정하지 마라. 다음 빌드에서 사라진다.
#
# 사용법:  ./build.sh
set -euo pipefail
cd "$(dirname "$0")"

HDR="src/install-header.md"
ENTRY="src/entry.mdc"
BODY="src/UX-UI-RULES.md"
CTX="context/_template.md"
OUT="dist/SETUP-UX-KIT.md"

for f in "$HDR" "$ENTRY" "$BODY" "$CTX"; do
  [ -f "$f" ] || { echo "❌ 없음: $f"; exit 1; }
done

mkdir -p dist
{
  cat "$HDR"
  printf '````\n'; cat "$ENTRY"; printf '````\n'
  printf '\n---\n\n## BLOCK B — `ux-kit/UX-UI-RULES.md`\n\n````\n'
  cat "$BODY"; printf '````\n'
  printf '\n---\n\n## BLOCK C — `ux-kit/context.md`\n\n````\n'
  cat "$CTX"; printf '````\n'
} > "$OUT"

FENCES=$(grep -c '^````$' "$OUT" || true)
[ "$FENCES" -eq 6 ] || { echo "❌ 펜스 개수 이상: $FENCES (기대값 6). 원본에 ```` 가 섞였는지 확인하라."; exit 1; }

head -1 "$ENTRY" | grep -q '^---$' || { echo "❌ $ENTRY 이 frontmatter로 시작하지 않는다."; exit 1; }
grep -q '^alwaysApply: true$' "$ENTRY" || { echo "❌ $ENTRY 의 alwaysApply가 true가 아니다."; exit 1; }

ENTRY_LINES=$(wc -l < "$ENTRY")
[ "$ENTRY_LINES" -le 40 ] || echo "⚠️ 경고: 진입점이 ${ENTRY_LINES}줄이다. 상시 로드되므로 짧게 유지하라."

echo "✅ 생성 완료: $OUT ($(wc -l < "$OUT") lines) / 진입점 ${ENTRY_LINES}줄"
