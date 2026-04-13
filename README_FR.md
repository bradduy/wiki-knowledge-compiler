<p align="center">
  <a href="./README.md">🇬🇧 English</a> &nbsp;·&nbsp;
  <a href="./README_VN.md">🇻🇳 Tiếng Việt</a> &nbsp;·&nbsp;
  <a href="./README_CN.md">🇨🇳 简体中文</a> &nbsp;·&nbsp;
  <a href="./README_KR.md">🇰🇷 한국어</a> &nbsp;·&nbsp;
  <a href="./README_JP.md">🇯🇵 日本語</a> &nbsp;·&nbsp;
  <a href="./README_DE.md">🇩🇪 Deutsch</a> &nbsp;·&nbsp;
  🇫🇷 <strong>Français</strong> &nbsp;·&nbsp;
  <a href="./README_RU.md">🇷🇺 Русский</a>
</p>

<h1 align="center">Wiki Knowledge Compiler</h1>

<p align="center">
  <em>Transformez vos documents en base de connaissances personnelle — propulsé par l'IA, stocké dans de simples fichiers.</em>
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

# 🇫🇷 Français

## 📖 Qu'est-ce que c'est ?

Un plugin pour [Claude Code](https://docs.anthropic.com/en/docs/claude-code) qui transforme vos documents en une base de connaissances organisée et consultable.

Donnez-lui n'importe quoi — articles, notes, PDFs, un dossier entier — et il va :

1. **Sauvegarder** vos originaux (ils ne sont jamais modifiés)
2. **Résumer** chaque source
3. **Extraire** les idées clés sur des pages dédiées
4. **Relier** les idées connexes à travers tout ce que vous avez ajouté
5. **Répondre** à vos questions avec des liens vers les sources

Tout reste sur votre ordinateur sous forme de fichiers texte. Pas de cloud. Pas de base de données. Pas de verrouillage.

---

## 🚀 Démarrage rapide

Trois étapes. Tout s'installe automatiquement — vous n'avez rien à configurer.

**Étape 1 — Installer le plugin :**
```
/plugin marketplace add bradduy/wiki-knowledge-compiler
```
Après l'ajout, configurez-le dans le marketplace :
1. Exécutez `/plugin` → sélectionnez l'onglet **Marketplace**
2. Trouvez **wiki-knowledge-compiler** et ouvrez-le
3. Cliquez sur **Enable** et choisissez le scope — sélectionnez le dossier projet où vous souhaitez placer votre wiki
4. Confirmez — cette étape autorise le plugin à créer des fichiers et exécuter des commandes dans ce dossier

<p align="center">
  <img src="./assets/user_scope_setting.png" alt="Paramètre de scope" width="100%" />
</p>

**Étape 2 — Lancer la configuration :**
```
/wiki-setup
```
Choisissez la taille de votre projet (petit, moyen ou grand). Le plugin s'occupe du reste — il installe les outils nécessaires, crée votre dossier wiki et propose même de configurer [Obsidian](https://obsidian.md).

<p align="center">
  <img src="./assets/obisidian.gif" alt="Parcourir le wiki avec Obsidian" width="100%" />
</p>

**Étape 3 — Ajouter votre premier document :**
```
/wiki-ingest ~/Documents/my-article.md
```

C'est fait. Votre wiki est opérationnel.

---

## 🎯 Ce que vous pouvez faire

Chaque commande vous indique quoi essayer ensuite.

| Commande | Ce qu'elle fait |
|----------|----------------|
| `/wiki-setup` | Configuration initiale (installe tout pour vous) |
| `/wiki-ingest` | Ajouter des documents — un fichier, un dossier entier ou une URL |
| `/wiki` | Poser une question, obtenir une réponse avec les sources |
| `/wiki-insights` | Trouver des motifs et des connexions entre vos sources |
| `/wiki-update` | Actualiser la table des matières |

**Ordre recommandé :** `/wiki-setup` → `/wiki-ingest` → `/wiki` → `/wiki-insights` → `/wiki-update`

---

## 📥 Ajouter des documents

```bash
# Un fichier
/wiki-ingest ~/Documents/article.md

# Un dossier entier (analyse tout son contenu)
/wiki-ingest ~/Documents/research/

# Plusieurs fichiers à la fois
/wiki-ingest ~/notes/meeting1.md ~/notes/meeting2.md

# Tous les PDFs d'un dossier
/wiki-ingest ~/papers/*.pdf

# Une URL
/wiki-ingest https://example.com/interesting-article

# Ou collez du texte directement après la commande
```

Pour les dossiers et fichiers multiples, le plugin affiche la progression.

---

## 🧪 Exemple : Du document à la connaissance

Supposons que vous ajoutiez un article sur le changement climatique :

```
/wiki-ingest ~/Articles/ipcc-summary-2023.md
```

Le plugin crée :

| Quoi | Description |
|------|------------|
| **Résumé** | Un aperçu d'une page de l'article avec évaluation de fiabilité |
| **Concepts** | Des pages pour les idées clés comme « budget carbone » et « points de bascule » |
| **Entités** | Des nœuds pour les choses concrètes — « GIEC », « Accord de Paris », « Dr. Smith » |
| **Page thématique** | Une page « science du climat » reliant tout ensemble |

Ajoutez un second article sur la politique énergétique. Le plugin détecte que les deux sources traitent des budgets carbone et les relie automatiquement — les concepts ont des relations typées (`extends`, `contradicts`, `depends-on`), et les entités se connectent entre les sources.

Quand vous demandez :
```
/wiki How do carbon budgets affect energy policy?
```

Le plugin ne se contente pas de chercher par mots-clés. Il parcourt le **graphe de connaissances** — partant du concept « budget carbone », suivant ses relations vers les entités et sujets connectés — et trouve des connexions que la recherche par mots-clés manquerait.

---

## 🧠 Graphe de connaissances

Chaque document que vous ajoutez ne crée pas seulement des pages — il construit un **graphe de connaissances**. Le plugin extrait des entités nommées (personnes, projets, technologies, décisions) et les connecte avec des relations typées.

```
Redis ──uses──→ Auth Service ──maintained-by──→ Sarah
  │                                              │
  └──depends-on──→ PostgreSQL           owns ←───┘
                        │                Auth Migration
                        └──replaces──→ MySQL
```

Quand vous demandez « quel est l'impact de la mise à jour de Redis ? », le plugin part du nœud Redis et suit les arêtes `uses`, `depends-on`, `maintained-by` — trouvant chaque service, personne et décision connectés.

**Ce qui est extrait automatiquement :**

| Type d'entité | Exemples |
|-------------|---------|
| Personnes | "Sarah Chen", "Andrej Karpathy" |
| Projets | "Auth Migration", "API Redesign" |
| Technologies | "Redis", "PostgreSQL", "Kubernetes" |
| Bibliothèques | "React", "PyTorch", "Express" |
| Décisions | "Passer à PostgreSQL", "Utiliser des microservices" |
| Organisations | "Platform Team", "Anthropic" |

---

## 📊 Fiabilité et suivi intelligent

Toutes les connaissances ne sont pas également fiables. Chaque page de votre wiki porte des métadonnées :

- **Fiabilité** — `high`, `medium` ou `low` selon le nombre de sources
- **Date de vérification** — quand le contenu a été confirmé exact pour la dernière fois
- **Autorité** — si la source est `primary` (recherche originale), `secondary` (analyse) ou `commentary` (opinion)
- **Relations typées** — les connexions entre concepts ont du sens : `extends`, `contradicts`, `supersedes`, `depends-on`

Quand deux sources se contredisent, le plugin signale la **contradiction** et lie les deux côtés. Quand une information plus récente remplace une ancienne, l'ancienne page est marquée **superseded** avec un lien vers son remplacement.

---

## 🔮 Parcourir votre wiki avec Obsidian

Pendant la configuration, on vous demandera si vous voulez [Obsidian](https://obsidian.md) — une application gratuite pour parcourir votre wiki visuellement. Elle s'installe automatiquement si vous acceptez.

Ouvrez votre dossier `knowledge-base/` dans Obsidian :

- **Vue graphique** — une carte visuelle de toutes vos pages et de leurs connexions
- **Rétroliens** — cliquez sur une page pour voir tout ce qui y renvoie
- **Recherche** — trouvez n'importe quoi dans votre wiki entier
- **Synchronisation en direct** — les nouvelles pages de `/wiki-ingest` apparaissent immédiatement

Optionnel. Votre wiki fonctionne parfaitement avec les commandes seules.

---

## 📁 Ce qui est créé

```
knowledge-base/
  raw/           Vos documents originaux (jamais modifiés)
  summaries/     Résumé d'une page pour chaque source
  concepts/      Idées clés, une par page
  topics/        Pages de synthèse regroupant les idées connexes
  insights/      Connexions découvertes entre les sources
  references/    Liens vers les ressources externes
  .data/         Données internes (cachées)
```

Tous les fichiers sont en Markdown. Ouvrez-les avec n'importe quel éditeur de texte, Obsidian ou VS Code.

---

## 💡 Conseils

- **Commencez petit.** Ajoutez 2–3 sources et essayez `/wiki` avant d'en ajouter davantage.
- **Soyez précis.** « Que dit la source X sur Y ? » fonctionne mieux que des questions vagues.
- **Essayez `/wiki-insights`** après avoir ajouté plusieurs sources sur un sujet — il trouve des motifs que vous pourriez manquer.
- **Vos sources sont en sécurité.** Le plugin ne modifie jamais vos fichiers originaux.

---

## ⚙️ Comment fonctionne la configuration

`/wiki-setup` gère tout automatiquement selon la taille de votre projet :

| Taille | Recherche | Ce qui est installé |
|--------|-----------|---------------------|
| **Petit** | Intégrée | Rien de supplémentaire |
| **Moyen** | Recherche intelligente ([qmd](https://github.com/tobi/qmd)) | Node.js + qmd (installés automatiquement) |
| **Grand** | Recherche la plus rapide | Node.js + qmd + serveur MCP (installés et configurés automatiquement) |

Le plugin détecte votre système d'exploitation (macOS, Linux, Windows) et installe tout avec la méthode adaptée. Si quelque chose échoue, il se rabat sur la recherche intégrée — vous n'êtes jamais bloqué.

---

## 📦 Autres méthodes d'installation

### Depuis le marketplace Claude Code (le plus simple)

```
/plugin marketplace add bradduy/wiki-knowledge-compiler
```
Après l'ajout, configurez-le dans le marketplace :
1. Exécutez `/plugin` → sélectionnez l'onglet **Marketplace**
2. Trouvez **wiki-knowledge-compiler** et ouvrez-le
3. Cliquez sur **Enable** et choisissez le scope — sélectionnez le dossier projet où vous souhaitez placer votre wiki
4. Confirmez — cette étape autorise le plugin à créer des fichiers et exécuter des commandes dans ce dossier

<p align="center">
  <img src="./assets/user_scope_setting.png" alt="Paramètre de scope" width="100%" />
</p>

### Cloner comme projet autonome

```bash
git clone https://github.com/bradduy/wiki-knowledge-compiler.git
cd wiki-knowledge-compiler
```

Ouvrez dans Claude Code et lancez `/wiki-setup`.

### Ajouter à un projet existant

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

Puis lancez `/wiki-setup`.

---

## 📌 Bon à savoir

- **Fonctionne hors ligne.** Tout est sur votre ordinateur.
- **Fichiers texte.** Pas de base de données ni de logiciel spécial nécessaire.
- **PDFs pris en charge.** Les mises en page complexes peuvent ne pas être extraites parfaitement.
- **Usage personnel.** Utilisateur unique.
- **Historique des versions ?** Lancez `git init` dans votre dossier de base de connaissances.

---

## 🤝 Contribuer

Vous souhaitez améliorer le plugin ? Consultez le [guide de contribution](.github/CONTRIBUTING.md) ou ouvrez une issue.

## 📄 Licence

MIT

---
