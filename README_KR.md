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

## 목차

- [최근 업데이트](#-최근-업데이트)
- [기능](#-기능)
- [다국어 지원](#-다국어-지원)
- [빠른 시작](#-빠른-시작)
- [사용법](#-사용법)
  - [문서 추가](#-문서-추가)
  - [예시: 문서에서 지식으로](#-예시-문서에서-지식으로)
- [지식 그래프](#-지식-그래프)
- [신뢰도 & 스마트 추적](#-신뢰도--스마트-추적)
- [Obsidian으로 위키 탐색](#-obsidian으로-위키-탐색)
- [설정 작동 방식](#%EF%B8%8F-설정-작동-방식)
- [다른 설치 방법](#-다른-설치-방법)
- [기여하기](#-기여하기)
- [라이선스](#-라이선스)

---

## 🆕 최근 업데이트

### v0.2.0 — 지식 그래프, 신뢰도 평가, 유형화된 관계
- 🧠 **지식 그래프** — 매 인제스트마다 명명된 엔티티(사람, 프로젝트, 기술, 결정)를 추출하고 `.data/entities/`에서 유형화된 관계로 연결합니다.
- 🔗 **유형화된 관계** — 개념이 의미를 가지고 서로 연결: `extends`, `contradicts`, `supersedes`, `depends-on`, `generalizes`, `component-of`.
- 📊 **신뢰도 평가** — 모든 페이지에 `confidence` 수준(`high`/`medium`/`low`), `verified` 날짜가 부여되며, 요약은 출처 `authority`(`primary`/`secondary`/`commentary`)를 추적합니다.
- 🔄 **대체** — 새로운 정보가 이전 것을 대체할 때, 페이지는 `supersedes`/`superseded_by`로 연결 — 삭제 없이 이력 추적 가능.
- 🕸️ **그래프 인식 쿼리** — `/wiki`가 키워드/의미 검색과 함께 엔티티 관계를 탐색하여 텍스트 검색이 놓치는 연결을 찾습니다.
- ⚡ **모순 감지** — 출처가 불일치할 때 양쪽 모두 자동으로 표시되고 연결됩니다.

> **v0.0.x에서 업그레이드?** `/wiki-setup`을 다시 실행하여 새로운 `.data/entities/` 디렉토리를 초기화하세요. 기존 wiki 페이지는 계속 정상 작동합니다 — 새 필드(`confidence`, `verified`, `entities`, 유형화된 `related`)는 새 문서를 인제스트하거나 `/wiki-update`를 실행할 때 점진적으로 추가됩니다. 마이그레이션이 필요 없습니다.

### v0.0.x — 기반
- 📅 **예약 업데이트** — `/wiki-schedule`가 원격 에이전트를 통해 cron 일정으로 `/wiki-update`를 자동 실행.
- 🔀 **혼합 인제스트** — `/wiki-ingest`가 단일 명령에서 파일 + URL을 동시 수용.
- 🔄 **업데이트 시 자동 인제스트** — `/wiki-update`가 `raw/`의 새 파일을 감지하고 인제스트.
- 📝 **간소화된 명령어** — `/wiki-query`를 `/wiki`로 이름 변경.
- 📁 **플랫 구조** — `knowledge-base/` 래퍼 제거; `raw/`와 `wiki/`가 프로젝트 루트에 배치.
- 📥 **배치 인제스트** — 폴더, 다중 파일, glob 패턴 지원.
- 🔍 **검색 티어** — 소형은 Grep, 중형/대형은 qmd.
- 🔮 **Obsidian 통합** — `/wiki-setup` 중 자동 설치 및 설정.
- ⚙️ **크로스 플랫폼 자동 설치** — Node.js, qmd, Obsidian을 macOS, Linux, Windows에서 지원.

---

## ✨ 기능

| 기능 | 설명 |
|------|------|
| **지식 그래프** | 사람, 프로젝트, 기술, 결정을 연결된 엔티티로 추출 |
| **유형화된 관계** | 개념과 엔티티가 의미적으로 연결(`extends`, `contradicts`, `depends-on`) |
| **신뢰도 추적** | 모든 페이지에 `high`/`medium`/`low` 평가 및 검증 날짜 |
| **출처 권위성** | 요약에 `primary`, `secondary`, `commentary` 태그 |
| **모순 감지** | 충돌하는 주장을 자동으로 표시하고 연결 |
| **대체** | 이전 주장을 대체 내용에 연결, 무단 삭제 없음 |
| **그래프 인식 쿼리** | `/wiki`가 키워드뿐 아니라 엔티티 관계를 탐색 |
| **다중 포맷 인제스트** | 파일, 폴더, URL, glob 패턴, 붙여넣기 텍스트 |
| **자동 요약** | 출처당 한 페이지 요약 및 핵심 포인트 |
| **개념 추출** | 출처당 3-10개의 원자적 개념, 자동 중복 제거 |
| **스마트 검색** | Grep(소형), qmd 하이브리드 검색(중형), qmd MCP(대형) |
| **예약 업데이트** | 원격 에이전트를 통한 cron 기반 자동 인제스트 |
| **Obsidian 통합** | 시각적 그래프 탐색, 백링크, 실시간 동기화 |
| **100% 오프라인** | 일반 마크다운 파일, 클라우드 없음, 데이터베이스 없음 |
| **크로스 플랫폼** | macOS, Linux, Windows 자동 설치 |

---

## 🌐 다국어 지원

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

---

## 🚀 빠른 시작

세 단계. 모든 것이 자동으로 설치됩니다 — 직접 설정할 필요가 없습니다.

**1단계 — 플러그인 설치:**
```
/plugin marketplace add bradduy/wiki-knowledge-compiler
```
추가 후 마켓플레이스에서 설정합니다:
1. `/plugin` 실행 → **Marketplace** 탭 선택
2. **wiki-knowledge-compiler**를 찾아 열기
3. **Enable** 클릭 후 scope 선택 — wiki를 만들 프로젝트 폴더를 선택합니다
4. 확인 — 이 단계에서 플러그인이 해당 폴더에서 파일을 생성하고 명령을 실행할 수 있는 권한을 부여합니다

<p align="center">
  <img src="./assets/user_scope_setting.png" alt="Scope 설정" width="100%" />
</p>

**2단계 — 설정 실행:**
```
/wiki-setup
```
프로젝트 규모를 선택하세요 (소형, 중형, 대형). 플러그인이 나머지를 처리합니다 — 필요한 도구 설치, 위키 폴더 생성, 그리고 [Obsidian](https://obsidian.md) 설정까지 제안합니다.

<p align="center">
  <img src="./assets/obisidian.gif" alt="Obsidian으로 wiki 탐색" width="100%" />
</p>

**3단계 — 첫 번째 문서 추가:**
```
/wiki-ingest ~/Documents/my-article.md
```

완료. 위키가 작동합니다.

---

## 🎯 사용법

각 명령어는 다음에 해볼 것을 알려주므로, 항상 다음 단계를 알 수 있습니다.

| 명령어 | 기능 |
|---------|-------------|
| `/wiki-setup` | ⚙️ 일회성 설정 (모든 것을 자동 설치) |
| `/wiki-ingest` | 📥 문서 추가 — 파일 하나, 폴더 전체 또는 URL |
| `/wiki` | 🔍 질문하고 출처가 포함된 답변 받기 |
| `/wiki-insights` | ✨ 출처 간 패턴과 연결 발견 |
| `/wiki-update` | 🔄 위키 동기화 (raw/의 새 파일 인제스트 + 인덱스 갱신) |
| `/wiki-schedule` | 📅 /wiki-update 자동 실행 예약 |

**권장 순서:** `/wiki-setup` → `/wiki-ingest` → `/wiki` → `/wiki-insights` → `/wiki-update` → `/wiki-schedule`

### 📥 문서 추가

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

### 🧪 예시: 문서에서 지식으로

기후 변화에 관한 기사를 추가한다고 가정합니다:

```
/wiki-ingest ~/Articles/ipcc-summary-2023.md
```

플러그인이 생성하는 것:

| 항목 | 설명 |
|------|------------|
| **요약** | 기사의 한 페이지 개요 (신뢰도 평가 포함) |
| **개념** | "탄소 예산"과 "티핑 포인트" 같은 핵심 아이디어 페이지 |
| **엔티티** | 구체적 항목의 노드 — "IPCC", "파리 협정", "Dr. Smith" |
| **주제 페이지** | 모든 것을 연결하는 "기후 과학" 페이지 |

에너지 정책 기사를 추가하면, 플러그인은 두 출처 모두 탄소 예산을 다루고 있음을 인식하고 자동 연결합니다 — 개념에는 유형화된 관계(`extends`, `contradicts`, `depends-on`)가 설정되고, 엔티티는 출처 간 연결됩니다.

질문하면:
```
/wiki How do carbon budgets affect energy policy?
```

플러그인은 키워드 검색만 하지 않습니다. **지식 그래프**를 탐색합니다 — "탄소 예산" 개념에서 시작하여 관련 엔티티와 주제로의 관계를 따라가며, 키워드 검색이 놓치는 연결을 찾습니다. **양쪽** 출처에서 정보를 끌어와 각 사실의 출처 링크가 포함된 답변을 제공합니다.

---

## 🧠 지식 그래프

추가하는 모든 문서는 페이지를 만들 뿐만 아니라 **지식 그래프**를 구축합니다. 플러그인은 명명된 엔티티(사람, 프로젝트, 기술, 결정)를 추출하고 유형화된 관계로 연결합니다.

```
Redis ──uses──→ Auth Service ──maintained-by──→ Brad
  │                                              │
  └──depends-on──→ PostgreSQL           owns ←───┘
                        │                Auth Migration
                        └──replaces──→ MySQL
```

"Redis 업그레이드의 영향은?"이라고 물으면, Redis 노드에서 `uses`, `depends-on`, `maintained-by` 엣지를 따라 나가며 관련된 모든 서비스, 사람, 결정을 찾습니다. "Redis"라는 이름이 언급된 페이지만 검색하는 것이 아닙니다.

**자동으로 추출되는 항목:**

| 엔티티 유형 | 예시 |
|-------------|---------|
| 사람 | "Brad Duy", "Andrej Karpathy" |
| 프로젝트 | "Auth Migration", "API Redesign" |
| 기술 | "Redis", "PostgreSQL", "Kubernetes" |
| 라이브러리 | "React", "PyTorch", "Express" |
| 결정 | "PostgreSQL로 전환", "마이크로서비스 사용" |
| 조직 | "Platform Team", "Anthropic" |

---

## 📊 신뢰도 & 스마트 추적

모든 지식이 동일하게 신뢰할 수 있는 것은 아닙니다. 위키의 각 페이지에는 메타데이터가 포함됩니다:

- **신뢰도** — 지원하는 출처 수에 따라 `high`, `medium`, `low`
- **검증 날짜** — 콘텐츠가 마지막으로 정확하다고 확인된 날짜
- **권위성** — 출처가 `primary`(원본 연구), `secondary`(리뷰), `commentary`(의견) 중 어느 것인지
- **유형화된 관계** — 개념 간 연결에 의미가 있음: `extends`, `contradicts`, `supersedes`, `depends-on`

두 출처가 충돌하면, 플러그인은 **모순**을 표시하고 양쪽을 연결합니다. 새로운 정보가 이전 것을 대체하면, 이전 페이지는 **superseded**로 표시되고 대체 내용으로 연결됩니다.

---

## 🔮 Obsidian으로 위키 탐색

설정 중에 [Obsidian](https://obsidian.md) 설치 여부를 물어봅니다 — 위키를 시각적으로 탐색할 수 있는 무료 앱입니다. 동의하면 자동으로 설치됩니다.

Obsidian에서 프로젝트 폴더를 열면:

- 🕸️ **그래프 뷰** — 모든 페이지와 연결 관계의 시각적 지도
- 🔙 **백링크** — 아무 페이지나 클릭하면 연결된 모든 것을 확인
- 🔍 **검색** — 전체 위키에서 무엇이든 검색
- ⚡ **실시간 동기화** — `/wiki-ingest`로 추가된 새 페이지가 즉시 표시

선택 사항입니다. 명령어만으로도 위키는 완벽하게 작동합니다.

---

## 📁 생성되는 구조

```
your-project/
  📄 raw/           원본 문서 (절대 수정하지 않음)
  📚 wiki/          모든 생성 페이지 (요약, 개념, 주제, 인사이트)
  .data/            내부 데이터 (숨김)
```

래퍼 폴더가 없습니다. `raw/`와 `wiki/`가 프로젝트 바로 안에 있습니다. `raw/`가 이미 존재하면 설정은 옆에 `wiki/`만 추가합니다.

모든 파일은 일반 Markdown 형식입니다. 아무 텍스트 편집기, Obsidian 또는 VS Code로 열 수 있습니다.

---

## 💡 팁

- 🌱 **작게 시작하세요.** 2–3개의 출처를 추가하고 `/wiki`를 먼저 시도하세요.
- 🎯 **구체적으로 질문하세요.** "출처 X가 Y에 대해 뭐라고 하나요?"가 모호한 질문보다 효과적입니다.
- ✨ **여러 출처를 추가한 후 `/wiki-insights`를 시도하세요** — 놓칠 수 있는 패턴을 찾아줍니다.
- 🔒 **원본 파일은 안전합니다.** 플러그인은 원본 파일을 절대 변경하지 않습니다.

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
추가 후 마켓플레이스에서 설정합니다:
1. `/plugin` 실행 → **Marketplace** 탭 선택
2. **wiki-knowledge-compiler**를 찾아 열기
3. **Enable** 클릭 후 scope 선택 — wiki를 만들 프로젝트 폴더를 선택합니다
4. 확인 — 이 단계에서 플러그인이 해당 폴더에서 파일을 생성하고 명령을 실행할 수 있는 권한을 부여합니다

<p align="center">
  <img src="./assets/user_scope_setting.png" alt="Scope 설정" width="100%" />
</p>

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
cp /tmp/wkc/.data/wiki.config.md your-project/.data/wiki.config.md
bash /tmp/wkc/scripts/init-kb.sh your-project/knowledge-base
rm -rf /tmp/wkc
```

그 다음 `/wiki-setup`을 실행하세요.

---

## 📌 알아두면 좋은 것들

- 📡 **오프라인으로 작동합니다.** 모든 것이 컴퓨터에 있습니다.
- 📄 **일반 텍스트 파일.** 데이터베이스나 특수 소프트웨어가 필요 없습니다.
- 📑 **PDF 지원.** 복잡한 레이아웃(표, 다단)은 완벽하게 추출되지 않을 수 있습니다.
- 👤 **개인 사용 목적.** 단일 사용자용입니다.
- 🕐 **버전 기록이 필요하신가요?** `git init`을 실행하세요.

---

## 🤝 기여하기

플러그인을 개선하고 싶으신가요? [기여 가이드](.github/CONTRIBUTING.md)를 참조하거나 이슈를 열어주세요.

## 📄 라이선스

MIT
