<p align="center">
  <a href="./README.md">🇬🇧 English</a> &nbsp;·&nbsp;
  <a href="./README_VN.md">🇻🇳 Tiếng Việt</a> &nbsp;·&nbsp;
  <a href="./README_CN.md">🇨🇳 简体中文</a> &nbsp;·&nbsp;
  🇰🇷 <strong>한국어</strong> &nbsp;·&nbsp;
  <a href="./README_JP.md">🇯🇵 日本語</a> &nbsp;·&nbsp;
  <a href="./README_DE.md">🇩🇪 Deutsch</a> &nbsp;·&nbsp;
  <a href="./README_FR.md">🇫🇷 Français</a> &nbsp;·&nbsp;
  <a href="./README_RU.md">🇷🇺 Русский</a>
</p>

<h1 align="center">Wiki Knowledge Compiler</h1>

<p align="center">
  <em>문서를 개인 지식 베이스로 변환 — AI 기반, 간단한 파일로 저장.</em>
</p>

<p align="center">
  <a href="https://github.com/bradduy/wiki-knowledge-compiler/blob/main/LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="MIT License" /></a>
  <a href="https://github.com/bradduy/wiki-knowledge-compiler"><img src="https://img.shields.io/badge/platform-Claude%20Code-blueviolet.svg" alt="Claude Code" /></a>
  <a href="https://obsidian.md"><img src="https://img.shields.io/badge/works%20with-Obsidian-7C3AED.svg" alt="Works with Obsidian" /></a>
  <img src="https://img.shields.io/badge/offline-100%25-brightgreen.svg" alt="100% Offline" />
</p>

<p align="center">
  <img src="./assets/demo.gif" alt="Wiki Knowledge Compiler Demo" width="100%" />
</p>

<p align="center">
  <img src="./assets/logo.png" alt="Wiki Knowledge Compiler Logo" width="100%" />
</p>

---

# 🇰🇷 한국어

## 📖 이것은 무엇인가요?

[Claude Code](https://docs.anthropic.com/en/docs/claude-code)용 플러그인으로, 문서를 체계적이고 검색 가능한 지식 베이스로 변환합니다.

어떤 것이든 넣을 수 있습니다 — 기사, 노트, PDF, 폴더 전체 — 플러그인이 다음을 수행합니다:

1. **저장** 원본 파일을 보존합니다 (절대 변경하지 않음)
2. **요약** 각 출처를 요약합니다
3. **추출** 핵심 아이디어를 별도 페이지로 만듭니다
4. **연결** 추가한 모든 자료에서 관련 아이디어를 연결합니다
5. **답변** 출처 링크와 함께 질문에 답합니다

모든 것이 일반 텍스트 파일로 컴퓨터에 저장됩니다. 클라우드 없음. 데이터베이스 없음. 종속성 없음.

---

## 🚀 빠른 시작

세 단계. 모든 것이 자동으로 설치됩니다 — 직접 설정할 필요가 없습니다.

**1단계 — 플러그인 설치:**
```
/plugin marketplace add bradduy/wiki-knowledge-compiler
```
그런 다음 `/plugin` → **wiki-knowledge-compiler** 마켓플레이스 선택 → 플러그인 선택 → **scope 활성화**. 이 단계에서 플러그인에 실행 권한을 부여합니다 — 활성화 후 `/wiki-` 명령어가 나타납니다.

**2단계 — 설정 실행:**
```
/wiki-setup
```
프로젝트 규모를 선택하세요 (소형, 중형, 대형). 플러그인이 나머지를 처리합니다 — 필요한 도구 설치, 위키 폴더 생성, 그리고 [Obsidian](https://obsidian.md) 설정까지 제안합니다.

**3단계 — 첫 번째 문서 추가:**
```
/wiki-ingest ~/Documents/my-article.md
```

완료. 위키가 작동합니다.

---

## 🎯 할 수 있는 것들

각 명령어는 다음에 해볼 것을 알려주므로, 항상 다음 단계를 알 수 있습니다.

| 명령어 | 기능 |
|---------|-------------|
| `/wiki-setup` | 일회성 설정 (모든 것을 자동 설치) |
| `/wiki-ingest` | 문서 추가 — 파일 하나, 폴더 전체 또는 URL |
| `/wiki` | 질문하고 출처가 포함된 답변 받기 |
| `/wiki-insights` | 출처 간 패턴과 연결 발견 |
| `/wiki-update` | 목차 갱신 |

**권장 순서:** `/wiki-setup` → `/wiki-ingest` → `/wiki` → `/wiki-insights` → `/wiki-update`

---

## 📥 문서 추가

다양한 방법으로 문서를 추가할 수 있습니다:

```bash
# 파일 하나
/wiki-ingest ~/Documents/article.md

# 폴더 전체 (내부의 모든 파일 스캔)
/wiki-ingest ~/Documents/research/

# 여러 파일을 한 번에
/wiki-ingest ~/notes/meeting1.md ~/notes/meeting2.md

# 폴더 내 모든 PDF
/wiki-ingest ~/papers/*.pdf

# URL
/wiki-ingest https://example.com/interesting-article

# 또는 명령어 뒤에 텍스트를 직접 붙여넣기
```

폴더나 여러 파일의 경우, 플러그인이 각 파일 처리 진행 상황을 표시합니다.

---

## 🧪 예시: 문서에서 지식으로

기후 변화에 관한 기사를 추가한다고 가정합니다:

```
/wiki-ingest ~/Articles/ipcc-summary-2023.md
```

플러그인이 생성하는 것:

| 항목 | 설명 |
|------|------------|
| **요약** | 기사의 한 페이지 개요 |
| **개념** | "탄소 예산"과 "티핑 포인트" 같은 핵심 아이디어 페이지 |
| **주제 페이지** | 모든 것을 연결하는 "기후 과학" 페이지 |

에너지 정책에 관한 두 번째 기사를 추가하면, 플러그인은 두 출처 모두 탄소 예산을 다루고 있음을 인식하고 자동으로 연결합니다.

질문하면:
```
/wiki How do carbon budgets affect energy policy?
```

**두** 출처를 종합한 답변을 받으며, 각 사실의 정확한 출처 링크가 포함됩니다.

---

## 🔮 Obsidian으로 위키 탐색

설정 중에 [Obsidian](https://obsidian.md) 설치 여부를 물어봅니다 — 위키를 시각적으로 탐색할 수 있는 무료 앱입니다. 동의하면 자동으로 설치됩니다.

Obsidian에서 `knowledge-base/` 폴더를 열면:

- **그래프 뷰** — 모든 페이지와 연결 관계의 시각적 지도
- **백링크** — 아무 페이지나 클릭하면 연결된 모든 것을 확인
- **검색** — 전체 위키에서 무엇이든 검색
- **실시간 동기화** — `/wiki-ingest`로 추가된 새 페이지가 즉시 표시

선택 사항입니다. 명령어만으로도 위키는 완벽하게 작동합니다.

---

## 📁 생성되는 구조

```
knowledge-base/
  raw/           원본 문서 (절대 수정하지 않음)
  summaries/     각 출처의 한 페이지 요약
  concepts/      핵심 아이디어, 하나당 한 페이지
  topics/        관련 아이디어를 묶는 상위 주제 페이지
  insights/      출처 간 발견된 연결
  index/         목차 (자동 생성)
  references/    외부 리소스 링크
  log.md         모든 작업 기록
```

모든 파일은 일반 Markdown 형식입니다. 아무 텍스트 편집기, Obsidian 또는 VS Code로 열 수 있습니다.

---

## 💡 팁

- **작게 시작하세요.** 2–3개의 출처를 추가하고 `/wiki`를 먼저 시도하세요.
- **구체적으로 질문하세요.** "출처 X가 Y에 대해 뭐라고 하나요?"가 모호한 질문보다 효과적입니다.
- **여러 출처를 추가한 후 `/wiki-insights`를 시도하세요** — 놓칠 수 있는 패턴을 찾아줍니다.
- **원본 파일은 안전합니다.** 플러그인은 원본 파일을 절대 변경하지 않습니다.

---

## ⚙️ 설정 작동 방식

`/wiki-setup`은 프로젝트 규모에 따라 모든 것을 자동으로 처리합니다:

| 규모 | 검색 방식 | 설치 내용 |
|------|--------|-------------------|
| **소형** | 내장 검색 | 추가 설치 불필요 |
| **중형** | 스마트 검색 ([qmd](https://github.com/tobi/qmd)) | Node.js + qmd (자동 설치) |
| **대형** | 최고속 검색 | Node.js + qmd + MCP 서버 (자동 설치 및 구성) |

플러그인이 운영체제(macOS, Linux, Windows)를 감지하고 적합한 방법으로 설치합니다. 실패하면 내장 검색으로 자동 대체됩니다 — 막히는 일은 없습니다.

---

## 📦 다른 설치 방법

### Claude Code 마켓플레이스에서 (가장 쉬움)

```
/plugin marketplace add bradduy/wiki-knowledge-compiler
```
그런 다음 `/plugin` → **wiki-knowledge-compiler** 마켓플레이스 선택 → 플러그인 선택 → **scope 활성화**. 이 단계에서 플러그인에 실행 권한을 부여합니다 — 활성화 후 `/wiki-` 명령어가 나타납니다.

### 독립 프로젝트로 클론

```bash
git clone https://github.com/bradduy/wiki-knowledge-compiler.git
cd wiki-knowledge-compiler
```

Claude Code에서 열고 `/wiki-setup`을 실행하세요.

### 기존 프로젝트에 추가

```bash
git clone https://github.com/bradduy/wiki-knowledge-compiler.git /tmp/wkc
cp -r /tmp/wkc/.claude/ your-project/.claude/
cp -r /tmp/wkc/.claude-plugin/ your-project/.claude-plugin/
cp -r /tmp/wkc/{agents,skills,templates} your-project/
cp /tmp/wkc/CLAUDE.md your-project/CLAUDE.md
cp /tmp/wkc/wiki.config.md your-project/wiki.config.md
bash /tmp/wkc/scripts/init-kb.sh your-project/knowledge-base
rm -rf /tmp/wkc
```

그 다음 `/wiki-setup`을 실행하세요.

---

## 📌 알아두면 좋은 것들

- **오프라인으로 작동합니다.** 모든 것이 컴퓨터에 있습니다.
- **일반 텍스트 파일.** 데이터베이스나 특수 소프트웨어가 필요 없습니다.
- **PDF 지원.** 복잡한 레이아웃(표, 다단)은 완벽하게 추출되지 않을 수 있습니다.
- **개인 사용 목적.** 단일 사용자용입니다.
- **버전 기록이 필요하신가요?** `git init`을 실행하세요.

---

## 🤝 기여하기

플러그인을 개선하고 싶으신가요? [기여 가이드](.github/CONTRIBUTING.md)를 참조하거나 이슈를 열어주세요.

## 📄 라이선스

MIT

---
