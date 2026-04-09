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

# 🇩🇪 Deutsch

## 📖 Was ist das?

Ein Plugin für [Claude Code](https://docs.anthropic.com/en/docs/claude-code), das Ihre Dokumente in eine organisierte, durchsuchbare Wissensdatenbank verwandelt.

Geben Sie ihm beliebige Inhalte — Artikel, Notizen, PDFs, einen ganzen Ordner — und es wird:

1. **Speichern** Ihrer Originale (sie werden nie verändert)
2. **Zusammenfassen** jeder Quelle
3. **Extrahieren** der Kernideen auf eigene Seiten
4. **Verknüpfen** verwandter Ideen über alle hinzugefügten Inhalte hinweg
5. **Beantworten** Ihrer Fragen mit Links zurück zu den Quellen

Alles bleibt auf Ihrem Computer als einfache Textdateien. Keine Cloud. Keine Datenbank. Kein Lock-in.

---

## 🚀 Schnellstart

Drei Schritte. Alles wird automatisch installiert — Sie müssen nichts selbst einrichten.

**Schritt 1 — Plugin installieren:**
```
/plugin marketplace add bradduy/wiki-knowledge-compiler
```
Dann gehen Sie zu `/plugin` → wählen Sie den **wiki-knowledge-compiler** Marketplace → wählen Sie das Plugin → **Scope aktivieren**. Dieser Schritt erteilt dem Plugin die Berechtigung, auf Ihrem Computer zu laufen — die `/wiki-` Befehle erscheinen danach.

**Schritt 2 — Setup ausführen:**
```
/wiki-setup
```
Wählen Sie Ihre Projektgröße (klein, mittel oder groß). Das Plugin erledigt den Rest — es installiert alle benötigten Tools, erstellt Ihren Wiki-Ordner und bietet sogar an, [Obsidian](https://obsidian.md) einzurichten.

**Schritt 3 — Erstes Dokument hinzufügen:**
```
/wiki-ingest ~/Documents/my-article.md
```

Fertig. Ihr Wiki ist einsatzbereit.

---

## 🎯 Was Sie tun können

Jeder Befehl zeigt Ihnen, was als Nächstes zu tun ist.

| Befehl | Was er macht |
|--------|-------------|
| `/wiki-setup` | Einmalige Einrichtung (installiert alles für Sie) |
| `/wiki-ingest` | Dokumente hinzufügen — eine Datei, einen ganzen Ordner oder eine URL |
| `/wiki-query` | Eine Frage stellen, Antwort mit Quellen erhalten |
| `/wiki-insights` | Muster und Verbindungen über Ihre Quellen hinweg finden |
| `/wiki-health` | Probleme finden und beheben (Duplikate, defekte Links) |
| `/wiki-update` | Inhaltsverzeichnis aktualisieren |

**Empfohlene Reihenfolge:** `/wiki-setup` → `/wiki-ingest` → `/wiki-query` → `/wiki-insights` → `/wiki-health` → `/wiki-update`

---

## 📥 Dokumente hinzufügen

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

---

## 🧪 Beispiel: Vom Dokument zum Wissen

Angenommen, Sie fügen einen Artikel über den Klimawandel hinzu:

```
/wiki-ingest ~/Articles/ipcc-summary-2023.md
```

Das Plugin erstellt:

| Was | Beschreibung |
|-----|-------------|
| **Zusammenfassung** | Ein einseitiger Überblick über den Artikel |
| **Konzepte** | Seiten für Kernideen wie „Kohlenstoffbudget" und „Kipppunkte" |
| **Themenseite** | Eine „Klimawissenschaft"-Seite, die alles verknüpft |

Fügen Sie einen zweiten Artikel über Energiepolitik hinzu. Das Plugin erkennt, dass beide Quellen Kohlenstoffbudgets behandeln, und verknüpft sie automatisch.

Wenn Sie fragen:
```
/wiki-query How do carbon budgets affect energy policy?
```

Erhalten Sie eine Antwort aus **beiden** Quellen, mit Links zu den genauen Stellen.

---

## 🔮 Ihr Wiki mit Obsidian durchsuchen

Während der Einrichtung werden Sie gefragt, ob Sie [Obsidian](https://obsidian.md) möchten — eine kostenlose App zum visuellen Durchsuchen Ihres Wikis. Sie wird automatisch installiert, wenn Sie zustimmen.

Öffnen Sie Ihren `knowledge-base/`-Ordner in Obsidian:

- **Graph-Ansicht** — eine visuelle Karte aller Seiten und ihrer Verbindungen
- **Backlinks** — klicken Sie auf eine Seite, um alles zu sehen, was darauf verlinkt
- **Suche** — finden Sie alles in Ihrem gesamten Wiki
- **Live-Synchronisierung** — neue Seiten von `/wiki-ingest` erscheinen sofort in Obsidian

Optional. Ihr Wiki funktioniert einwandfrei nur mit den Befehlen.

---

## 📁 Was erstellt wird

```
knowledge-base/
  raw/           Ihre Originaldokumente (werden nie verändert)
  summaries/     Einseitige Zusammenfassung jeder Quelle
  concepts/      Kernideen, eine pro Seite
  topics/        Übergeordnete Seiten, die verwandte Ideen gruppieren
  insights/      Entdeckte Verbindungen über Quellen hinweg
  index/         Inhaltsverzeichnis (automatisch generiert)
  references/    Links zu externen Ressourcen
  log.md         Ein Protokoll über alles, was passiert ist
```

Alle Dateien sind einfaches Markdown. Öffnen Sie sie mit jedem Texteditor, Obsidian oder VS Code.

---

## 💡 Tipps

- **Klein anfangen.** Fügen Sie 2–3 Quellen hinzu und probieren Sie `/wiki-query` aus.
- **Seien Sie spezifisch.** „Was sagt Quelle X über Y?" funktioniert besser als vage Fragen.
- **Führen Sie `/wiki-health` gelegentlich aus.** Es hält alles ordentlich.
- **Probieren Sie `/wiki-insights`** nach mehreren Quellen zu einem Thema — es findet Muster, die Sie übersehen könnten.
- **Ihre Quellen sind sicher.** Das Plugin verändert Ihre Originaldateien nie.

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
Dann gehen Sie zu `/plugin` → wählen Sie den **wiki-knowledge-compiler** Marketplace → wählen Sie das Plugin → **Scope aktivieren**. Dieser Schritt erteilt dem Plugin die Berechtigung, auf Ihrem Computer zu laufen — die `/wiki-` Befehle erscheinen danach.

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
cp /tmp/wkc/wiki.config.md your-project/wiki.config.md
bash /tmp/wkc/scripts/init-kb.sh your-project/knowledge-base
rm -rf /tmp/wkc
```

Dann `/wiki-setup` ausführen.

---

## 📌 Gut zu wissen

- **Funktioniert offline.** Alles befindet sich auf Ihrem Computer.
- **Einfache Textdateien.** Keine Datenbank oder spezielle Software nötig.
- **PDFs werden unterstützt.** Komplexe Layouts werden möglicherweise nicht perfekt extrahiert.
- **Für den persönlichen Gebrauch.** Einzelnutzer.
- **Versionsverlauf gewünscht?** Führen Sie `git init` in Ihrem Knowledge-Base-Ordner aus.

---

## 🤝 Mitwirken

Möchten Sie das Plugin verbessern? Lesen Sie die [Mitwirkungsrichtlinien](.github/CONTRIBUTING.md) oder eröffnen Sie ein Issue.

## 📄 Lizenz

MIT

---
