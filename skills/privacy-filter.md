---
name: privacy-filter
description: Skill for stripping sensitive data from content before it enters the wiki — API keys, tokens, passwords, PII
type: rigid
---

# Privacy Filter Skill

This skill governs how sensitive data is detected and stripped during ingestion. It runs **before** any content is written to summaries, concepts, or entities. Follow it exactly.

## When to apply

Apply this filter:
- During `/wiki-ingest` — after reading the source, before writing any derived content
- During `/wiki` write-back — before persisting query answers
- During `/wiki-insights` — before writing insight pages

Do NOT apply to files in `raw/` — the raw source is stored as-is (the user chose to add it). The filter only applies to **derived content** that the LLM writes.

## What to detect and strip

### Tier 1: Always strip (high risk)

| Pattern | Examples | Action |
|---------|----------|--------|
| API keys | `sk-...`, `AKIA...`, `ghp_...`, `xox-...` | Replace with `[REDACTED: API key]` |
| Passwords | `password=`, `passwd:`, `secret:` followed by a value | Replace value with `[REDACTED: password]` |
| Tokens | `token=`, `bearer `, `authorization:` followed by a value | Replace value with `[REDACTED: token]` |
| Private keys | `-----BEGIN.*PRIVATE KEY-----` blocks | Replace entire block with `[REDACTED: private key]` |
| Connection strings | `mongodb://user:pass@`, `postgres://user:pass@`, `mysql://user:pass@` | Replace credentials with `[REDACTED: credentials]`, keep the host/db structure |
| AWS credentials | `aws_access_key_id`, `aws_secret_access_key` values | Replace with `[REDACTED: AWS credential]` |

### Tier 2: Strip by default, configurable (medium risk)

| Pattern | Examples | Action |
|---------|----------|--------|
| Email addresses | `user@domain.com` | Replace with `[REDACTED: email]` unless it's a public/author email |
| IP addresses | `192.168.x.x`, `10.x.x.x` (private ranges) | Replace with `[REDACTED: internal IP]` |
| File paths with usernames | `/Users/john/`, `/home/jane/`, `C:\Users\bob\` | Replace username with `[user]` (e.g., `/Users/[user]/`) |
| Phone numbers | `+1-555-...`, `(555) 555-...` | Replace with `[REDACTED: phone]` |

### Tier 3: Flag only, don't strip (low risk)

| Pattern | Examples | Action |
|---------|----------|--------|
| Internal URLs | `*.internal`, `*.local`, `localhost:*` | Add `[internal URL]` marker but keep the URL |
| Names in PII context | Names paired with SSN, DOB, salary | Flag as `[potential PII: review]` |

## Detection patterns

Use these regex patterns for Tier 1 detection:

```
# API keys (common prefixes)
sk-[a-zA-Z0-9]{20,}
AKIA[A-Z0-9]{16}
ghp_[a-zA-Z0-9]{36}
xox[bpras]-[a-zA-Z0-9-]+
glpat-[a-zA-Z0-9_-]{20,}

# Generic secrets
(?i)(password|passwd|secret|token|api_key|apikey|auth)\s*[:=]\s*\S+

# Private keys
-----BEGIN\s+(RSA\s+)?PRIVATE\s+KEY-----[\s\S]*?-----END\s+(RSA\s+)?PRIVATE\s+KEY-----

# Connection strings with credentials
(mongodb|postgres|mysql|redis|amqp):\/\/[^:]+:[^@]+@
```

## Procedure during ingest

1. **Read the raw source content.**
2. **Scan for Tier 1 patterns.** If found:
   - Strip from all derived content (summaries, concepts, entities).
   - Log what was stripped: `[DATE] Privacy filter: stripped [N] secrets from [source name]`
   - Do NOT strip from the file in `raw/` — that's immutable.
3. **Scan for Tier 2 patterns.** If found:
   - Strip by default.
   - If the pattern appears to be public info (author email, published IP), keep it.
4. **Scan for Tier 3 patterns.** If found:
   - Add inline markers but keep the content.
5. **Proceed with normal ingestion** using the filtered content.

## Visibility field

All pages support an optional `visibility` field in frontmatter:

```yaml
visibility: "public"    # Safe to share (default if omitted)
visibility: "private"   # Contains info the user wants to keep private
visibility: "internal"  # References internal systems/URLs
```

When creating derived pages:
- If the source contains Tier 1 redactions, set `visibility: private`
- If the source contains internal URLs or Tier 3 flags, set `visibility: internal`
- Otherwise, leave as default (public)

## What NOT to filter

- **Public information** from published sources — author names, published emails, public URLs
- **Technical identifiers** that aren't secrets — port numbers, version numbers, config keys (not values)
- **Content the user explicitly provides** — if they paste content with an API key and ask to ingest it, the raw file keeps the key; only derived content is filtered
- **Placeholder/example values** — `password=example123`, `token=YOUR_TOKEN_HERE` are not real secrets

## User override

If the user says "don't filter this" or "keep the credentials," respect their request for that specific ingestion. But still add `visibility: private` to the derived pages as a safety net.
