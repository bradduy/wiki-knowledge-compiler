<h1 align="center">Wiki Knowledge Compiler</h1>

<p align="center">
  <em>Verwandeln Sie Ihre Dokumente in eine persönliche Wissensdatenbank — KI-gestützt, als einfache Dateien gespeichert.</em>
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

## Inhaltsverzeichnis

- [Aktuelle Updates](#-aktuelle-updates)
- [Funktionen](#-funktionen)
- [Lokalisierungen](#-lokalisierungen)
- [Schnellstart](#-schnellstart)
- [Nutzung](#-nutzung)
  - [Dokumente hinzufügen](#-dokumente-hinzufügen)
  - [Beispiel: Vom Dokument zum Wissen](#-beispiel-vom-dokument-zum-wissen)
- [Wissensgraph](#-wissensgraph)
- [Vertrauensstufen & intelligentes Tracking](#-vertrauensstufen--intelligentes-tracking)
- [Ihr Wiki mit Obsidian durchsuchen](#-ihr-wiki-mit-obsidian-durchsuchen)
- [Wie die Einrichtung funktioniert](#%EF%B8%8F-wie-die-einrichtung-funktioniert)
- [Weitere Installationsmethoden](#-weitere-installationsmethoden)
- [Mitwirken](#-mitwirken)
- [Lizenz](#-lizenz)

---

## 🆕 Aktuelle Updates

### v2.0.0 — Wissensgraph, Vertrauensbewertung und typisierte Beziehungen
- 🧠 **Wissensgraph** — Jede Aufnahme extrahiert benannte Entitäten (Personen, Projekte, Technologien, Entscheidungen) und verbindet sie mit typisierten Beziehungen in `.data/entities/`.
- 🔗 **Typisierte Beziehungen** — Konzepte verknüpfen sich mit Bedeutung: `extends`, `contradicts`, `supersedes`, `depends-on`, `generalizes`, `component-of`.
- 📊 **Vertrauensbewertung** — Jede Seite trägt ein `confidence`-Level (`high`/`medium`/`low`), ein `verified`-Datum, und Zusammenfassungen verfolgen die Quell-`authority` (`primary`/`secondary`/`commentary`).
- 🔄 **Ablösung** — Wenn neue Informationen alte ersetzen, werden Seiten mit `supersedes`/`superseded_by` verknüpft — nichts wird gelöscht, die Historie ist nachvollziehbar.
- 🕸️ **Graphbasierte Abfragen** — `/wiki` durchläuft jetzt Entitätsbeziehungen neben Schlüsselwort-/Semantiksuche, um Verbindungen zu finden, die Textsuche übersieht.
- ⚡ **Widerspruchserkennung** — Wenn Quellen nicht übereinstimmen, werden beide Seiten automatisch markiert und verlinkt.

### v1.x — Grundlage
- 📅 **Geplante Updates** — `/wiki-schedule` führt `/wiki-update` automatisch nach Cron-Zeitplan über Remote-Agenten aus.
- 🔀 **Gemischte Aufnahme** — `/wiki-ingest` akzeptiert Dateien + URLs in einem einzigen Befehl.
- 🔄 **Auto-Aufnahme bei Update** — `/wiki-update` erkennt und nimmt neue Dateien in `raw/` auf.
- 📝 **Einfachere Befehle** — `/wiki-query` umbenannt zu `/wiki`.
- 📁 **Flache Struktur** — `knowledge-base/`-Wrapper entfernt; `raw/` und `wiki/` liegen im Projektstamm.
- 📥 **Batch-Aufnahme** — Ordner, mehrere Dateien und Glob-Muster.
- 🔍 **Suchstufen** — Grep für kleine Projekte, qmd für mittlere/große.
- 🔮 **Obsidian-Integration** — Automatische Installation und Einrichtung während `/wiki-setup`.
- ⚙️ **Plattformübergreifende Auto-Installation** — Node.js, qmd, Obsidian auf macOS, Linux und Windows.

---

## ✨ Funktionen

| Funktion | Beschreibung |
|----------|-------------|
| **Wissensgraph** | Extrahiert Personen, Projekte, Technologien, Entscheidungen als verbundene Entitäten |
| **Typisierte Beziehungen** | Konzepte und Entitäten mit semantischer Bedeutung verknüpft (`extends`, `contradicts`, `depends-on`) |
| **Vertrauens-Tracking** | Jede Seite mit `high`/`medium`/`low` bewertet, mit Verifizierungsdatum |
| **Quellautorität** | Zusammenfassungen als `primary`, `secondary` oder `commentary` gekennzeichnet |
| **Widerspruchserkennung** | Widersprüchliche Aussagen automatisch markiert und verlinkt |
| **Ablösung** | Alte Aussagen mit Ersatz verlinkt, nie stillschweigend gelöscht |
| **Graphbasierte Abfragen** | `/wiki` durchläuft Entitätsbeziehungen, nicht nur Schlüsselwörter |
| **Multi-Format-Aufnahme** | Dateien, Ordner, URLs, Glob-Muster, eingefügter Text |
| **Auto-Zusammenfassungen** | Eine Seite pro Quelle mit Kernaussagen |
| **Konzeptextraktion** | 3-10 atomare Konzepte pro Quelle, automatisch dedupliziert |
| **Intelligente Suche** | Grep (klein), qmd Hybridsuche (mittel), qmd MCP (groß) |
| **Geplante Updates** | Cron-basierte Auto-Aufnahme über Remote-Agenten |
| **Obsidian-Integration** | Visuelles Graph-Browsing, Backlinks, Live-Sync |
| **100% offline** | Einfache Markdown-Dateien, keine Cloud, keine Datenbank |
| **Plattformübergreifend** | macOS, Linux, Windows mit Auto-Installation |

---

## 🌐 Lokalisierungen

<p align="center">
  <a href="./README.md">🇬🇧 English</a> &nbsp;·&nbsp;
  <a href="./README_VN.md">🇻🇳 Tiếng Việt</a> &nbsp;·&nbsp;
  <a href="./README_CN.md">🇨🇳 简体中文</a> &nbsp;·&nbsp;
  <a href="./README_KR.md">🇰🇷 한국어</a> &nbsp;·&nbsp;
  <a href="./README_JP.md">🇯🇵 日本語</a> &nbsp;·&nbsp;
  🇩🇪 <strong>Deutsch</strong> &nbsp;·&nbsp;
  <a href="./README_FR.md">🇫🇷 Français</a> &nbsp;·&nbsp;
  <a href="./README_RU.md">🇷🇺 Русский</a>
</p>

---

## 🚀 Schnellstart

Drei Schritte. Alles wird automatisch installiert — Sie müssen nichts selbst einrichten.

**Schritt 1 — Plugin installieren:**
```
/plugin marketplace add bradduy/wiki-knowledge-compiler
```
Nach dem Hinzufügen konfigurieren Sie es im Marketplace:
1. `/plugin` ausführen → Registerkarte **Marketplace** wählen
2. **wiki-knowledge-compiler** finden und öffnen
3. **Enable** klicken und den Scope wählen — wählen Sie den Projektordner, in dem Ihr Wiki gespeichert werden soll
4. Bestätigen — dieser Schritt erteilt dem Plugin die Berechtigung, Dateien zu erstellen und Befehle in diesem Ordner auszuführen

<p align="center">
  <img src="./assets/user_scope_setting.png" alt="Scope-Einstellung" width="100%" />
</p>

**Schritt 2 — Setup ausführen:**
```
/wiki-setup
```
Wählen Sie Ihre Projektgröße (klein, mittel oder groß). Das Plugin erledigt den Rest — es installiert alle benötigten Tools, erstellt Ihren Wiki-Ordner und bietet sogar an, [Obsidian](https://obsidian.md) einzurichten.

<p align="center">
  <img src="./assets/obisidian.gif" alt="Wiki in Obsidian durchsuchen" width="100%" />
</p>

**Schritt 3 — Erstes Dokument hinzufügen:**
```
/wiki-ingest ~/Documents/my-article.md
```

Fertig. Ihr Wiki ist einsatzbereit.

---

## 🎯 Nutzung

Jeder Befehl zeigt Ihnen, was als Nächstes zu tun ist.

| Befehl | Was er macht |
|--------|-------------|
| `/wiki-setup` | ⚙️ Einmalige Einrichtung (installiert alles für Sie) |
| `/wiki-ingest` | 📥 Dokumente hinzufügen — eine Datei, einen ganzen Ordner oder eine URL |
| `/wiki` | 🔍 Eine Frage stellen, Antwort mit Quellen erhalten |
| `/wiki-insights` | ✨ Muster und Verbindungen über Ihre Quellen hinweg finden |
| `/wiki-update` | 🔄 Wiki synchronisieren (neue Dateien in raw/ aufnehmen + Indizes aktualisieren) |
| `/wiki-schedule` | 📅 /wiki-update automatisch nach Zeitplan ausführen |

**Empfohlene Reihenfolge:** `/wiki-setup` → `/wiki-ingest` → `/wiki` → `/wiki-insights` → `/wiki-update` → `/wiki-schedule`

### 📥 Dokumente hinzufügen

Sie können Dokumente auf verschiedene Weisen hinzufügen:

```bash
# Eine Datei
/wiki-ingest ~/Documents/article.md

# Ein ganzer Ordner (durchsucht alles darin)
/wiki-ingest ~/Documents/research/

# Mehrere Dateien auf einmal
/wiki-ingest ~/notes/meeting1.md ~/notes/meeting2.md

# Alle PDFs in einem Ordner
/wiki-ingest ~/papers/*.pdf

# Eine URL
/wiki-ingest https://example.com/interesting-article

# Oder fügen Sie Text direkt nach dem Befehl ein
```

Bei Ordnern und mehreren Dateien zeigt das Plugin den Fortschritt an.

### 🧪 Beispiel: Vom Dokument zum Wissen

Angenommen, Sie fügen einen Artikel über den Klimawandel hinzu:

```
/wiki-ingest ~/Articles/ipcc-summary-2023.md
```

Das Plugin erstellt:

| Was | Beschreibung |
|-----|-------------|
| **Zusammenfassung** | Ein einseitiger Überblick über den Artikel mit Vertrauensbewertung |
| **Konzepte** | Seiten für Kernideen wie „Kohlenstoffbudget" und „Kipppunkte" |
| **Entitäten** | Knoten für konkrete Dinge — „IPCC", „Pariser Abkommen", „Dr. Smith" |
| **Themenseite** | Eine „Klimawissenschaft"-Seite, die alles verknüpft |

Fügen Sie einen zweiten Artikel über Energiepolitik hinzu. Das Plugin erkennt, dass beide Quellen Kohlenstoffbudgets behandeln, und verknüpft sie automatisch — Konzepte erhalten typisierte Beziehungen (`extends`, `contradicts`, `depends-on`), und Entitäten verbinden sich quellenübergreifend.

Wenn Sie fragen:
```
/wiki How do carbon budgets affect energy policy?
```

Das Plugin sucht nicht nur nach Schlüsselwörtern. Es durchläuft den **Wissensgraphen** — ausgehend vom Konzept „Kohlenstoffbudget", folgt es Beziehungen zu verbundenen Entitäten und Themen — und findet Verbindungen, die eine Schlüsselwortsuche übersehen würde. Sie erhalten eine Antwort aus **beiden** Quellen, mit Links zu den genauen Ursprüngen jeder Aussage.

---

## 🧠 Wissensgraph

Jedes Dokument, das Sie hinzufügen, erstellt nicht nur Seiten — es baut einen **Wissensgraphen** auf. Das Plugin extrahiert benannte Entitäten (Personen, Projekte, Technologien, Entscheidungen) und verbindet sie mit typisierten Beziehungen.

```
Redis ──uses──→ Auth Service ──maintained-by──→ Sarah
  │                                              │
  └──depends-on──→ PostgreSQL           owns ←───┘
                        │                Auth Migration
                        └──replaces──→ MySQL
```

Wenn Sie fragen „Was sind die Auswirkungen eines Redis-Upgrades?", geht das Plugin vom Redis-Knoten aus über `uses`-, `depends-on`- und `maintained-by`-Kanten — und findet jeden verbundenen Service, jede Person und jede Entscheidung. Nicht nur Seiten, die „Redis" namentlich erwähnen.

**Was automatisch extrahiert wird:**

| Entitätstyp | Beispiele |
|-------------|---------|
| Personen | "Sarah Chen", "Andrej Karpathy" |
| Projekte | "Auth Migration", "API Redesign" |
| Technologien | "Redis", "PostgreSQL", "Kubernetes" |
| Bibliotheken | "React", "PyTorch", "Express" |
| Entscheidungen | "Wechsel zu PostgreSQL", "Microservices nutzen" |
| Organisationen | "Platform Team", "Anthropic" |

---

## 📊 Vertrauensstufen & intelligentes Tracking

Nicht alles Wissen ist gleich zuverlässig. Jede Seite in Ihrem Wiki trägt Metadaten:

- **Vertrauen** — `high`, `medium` oder `low`, basierend auf der Anzahl unterstützender Quellen
- **Verifizierungsdatum** — wann der Inhalt zuletzt als korrekt bestätigt wurde
- **Autorität** — ob eine Quelle `primary` (Originalforschung), `secondary` (Review) oder `commentary` (Meinung) ist
- **Typisierte Beziehungen** — Verbindungen zwischen Konzepten haben Bedeutung: `extends`, `contradicts`, `supersedes`, `depends-on`

Wenn zwei Quellen sich widersprechen, markiert das Plugin den **Widerspruch** und verlinkt beide Seiten. Wenn neuere Informationen ältere ersetzen, wird die alte Seite als **superseded** markiert mit einem Link zum Ersatz.

---

## 🔮 Ihr Wiki mit Obsidian durchsuchen

Während der Einrichtung werden Sie gefragt, ob Sie [Obsidian](https://obsidian.md) möchten — eine kostenlose App zum visuellen Durchsuchen Ihres Wikis. Sie wird automatisch installiert, wenn Sie zustimmen.

Öffnen Sie Ihren Projektordner in Obsidian:

- 🕸️ **Graph-Ansicht** — eine visuelle Karte aller Seiten und ihrer Verbindungen
- 🔙 **Backlinks** — klicken Sie auf eine Seite, um alles zu sehen, was darauf verlinkt
- 🔍 **Suche** — finden Sie alles in Ihrem gesamten Wiki
- ⚡ **Live-Synchronisierung** — neue Seiten von `/wiki-ingest` erscheinen sofort in Obsidian

Optional. Ihr Wiki funktioniert einwandfrei nur mit den Befehlen.

---

## 📁 Was erstellt wird

```
your-project/
  📄 raw/           Ihre Originaldokumente (werden nie verändert)
  📚 wiki/          Alle generierten Seiten (Zusammenfassungen, Konzepte, Themen, Insights)
  .data/            Interne Arbeitsdaten (versteckt)
```

Kein Wrapper-Ordner. `raw/` und `wiki/` liegen direkt in Ihrem Projekt. Wenn `raw/` bereits existiert, fügt das Setup nur `wiki/` daneben hinzu.

Alle Dateien sind einfaches Markdown. Öffnen Sie sie mit jedem Texteditor, Obsidian oder VS Code.

---

## 💡 Tipps

- 🌱 **Klein anfangen.** Fügen Sie 2–3 Quellen hinzu und probieren Sie `/wiki` aus.
- 🎯 **Seien Sie spezifisch.** „Was sagt Quelle X über Y?" funktioniert besser als vage Fragen.
- ✨ **Probieren Sie `/wiki-insights`** nach mehreren Quellen zu einem Thema — es findet Muster, die Sie übersehen könnten.
- 🔒 **Ihre Quellen sind sicher.** Das Plugin verändert Ihre Originaldateien nie.

---

## ⚙️ Wie die Einrichtung funktioniert

`/wiki-setup` erledigt alles automatisch basierend auf Ihrer Projektgröße:

| Größe | Suche | Was installiert wird |
|-------|-------|---------------------|
| **Klein** | Integriert | Nichts Zusätzliches nötig |
| **Mittel** | Intelligente Suche ([qmd](https://github.com/tobi/qmd)) | Node.js + qmd (automatisch installiert) |
| **Groß** | Schnellste Suche | Node.js + qmd + MCP-Server (automatisch installiert und konfiguriert) |

Das Plugin erkennt Ihr Betriebssystem (macOS, Linux, Windows) und installiert alles mit der passenden Methode. Falls etwas fehlschlägt, wird auf die integrierte Suche zurückgegriffen — Sie sind nie blockiert.

---

## 📦 Weitere Installationsmethoden

### Aus dem Claude Code Marketplace (am einfachsten)

```
/plugin marketplace add bradduy/wiki-knowledge-compiler
```
Nach dem Hinzufügen konfigurieren Sie es im Marketplace:
1. `/plugin` ausführen → Registerkarte **Marketplace** wählen
2. **wiki-knowledge-compiler** finden und öffnen
3. **Enable** klicken und den Scope wählen — wählen Sie den Projektordner, in dem Ihr Wiki gespeichert werden soll
4. Bestätigen — dieser Schritt erteilt dem Plugin die Berechtigung, Dateien zu erstellen und Befehle in diesem Ordner auszuführen

<p align="center">
  <img src="./assets/user_scope_setting.png" alt="Scope-Einstellung" width="100%" />
</p>

### Als eigenständiges Projekt klonen

```bash
git clone https://github.com/bradduy/wiki-knowledge-compiler.git
cd wiki-knowledge-compiler
```

In Claude Code öffnen und `/wiki-setup` ausführen.

### Zu einem bestehenden Projekt hinzufügen

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

Dann `/wiki-setup` ausführen.

---

## 📌 Gut zu wissen

- 📡 **Funktioniert offline.** Alles befindet sich auf Ihrem Computer.
- 📄 **Einfache Textdateien.** Keine Datenbank oder spezielle Software nötig.
- 📑 **PDFs werden unterstützt.** Komplexe Layouts werden möglicherweise nicht perfekt extrahiert.
- 👤 **Für den persönlichen Gebrauch.** Einzelnutzer.
- 🕐 **Versionsverlauf gewünscht?** Führen Sie `git init` in Ihrem Knowledge-Base-Ordner aus.

---

## 🤝 Mitwirken

Möchten Sie das Plugin verbessern? Lesen Sie die [Mitwirkungsrichtlinien](.github/CONTRIBUTING.md) oder eröffnen Sie ein Issue.

## 📄 Lizenz

MIT
