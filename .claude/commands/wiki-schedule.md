---
name: wiki-schedule
description: Schedule /wiki-update to run automatically — by time, interval, or both
---

# Wiki Schedule

Help the user set up automatic `/wiki-update` runs. This creates a remote scheduled agent that checks `raw/` for new files and rebuilds indexes on a schedule.

## Procedure

### Step 1: Ask what kind of schedule (MUST ASK)

Present this to the user and **WAIT for their answer**:

```
How would you like to schedule /wiki-update?

  1. ⏰ At a specific time every day (e.g. "every day at 9am")
  2. 🔁 On a repeating interval (e.g. "every 2 hours")
  3. 📅 At a specific time on certain days (e.g. "every Monday at 10am")
  4. 🎯 Both — daily at a specific time AND on an interval

Enter 1-4:
```

### Step 2: Collect schedule details based on their choice

**If 1 (daily at specific time):**
- Ask: `What time? (Your timezone is Asia/Saigon)`
- Give examples: 6am, 9am, 12pm, 6pm, 10pm
- Convert their local time to UTC: Asia/Saigon is UTC+7
  - e.g. 9am Saigon = 2am UTC → cron: `0 2 * * *`
- Confirm: `9:00 AM Saigon = 2:00 AM UTC. Schedule: daily at 9:00 AM your time. Correct?`

**If 2 (repeating interval):**
- Ask: `How often?`
- Give options:
  ```
  1. Every 1 hour
  2. Every 2 hours
  3. Every 4 hours
  4. Every 6 hours
  5. Every 12 hours
  ```
- Minimum is 1 hour. If they ask for less, explain the minimum.
- Convert to cron: e.g. every 2 hours → `0 */2 * * *`

**If 3 (specific days):**
- Ask: `Which days?` (Monday-Friday, weekends, specific days)
- Ask: `What time?`
- Convert to cron: e.g. Monday & Wednesday at 9am Saigon → `0 2 * * 1,3`

**If 4 (both):**
- Collect both a daily time AND an interval
- This creates TWO separate schedules
- Collect daily time first, then interval

### Step 3: Confirm the schedule

Show the user what will be created:

```
Here's what I'll set up:

  📋 Name: wiki-update-daily (or wiki-update-interval, etc.)
  ⏰ Schedule: Every day at 9:00 AM (your time) / Every 2 hours
  🔧 What it does: Checks raw/ for new files, ingests them, rebuilds indexes
  🤖 Model: claude-sonnet-4-6
  📂 Repo: bradduy/wiki-knowledge-compiler

Create this schedule? (yes/no)
```

Wait for confirmation.

### Step 4: Check prerequisites

Before creating the trigger:

1. Remind the user: **The Claude GitHub App must be installed** on their repo for the remote agent to access it.
   - If not installed: `⚠ You need to install the Claude GitHub App first: https://claude.ai/code/onboarding?magic=github-app-setup`
   - Ask if they want to continue anyway or install first.

### Step 5: Create the trigger(s)

Use the `RemoteTrigger` tool with `action: "create"`.

**The prompt for the remote agent should be:**

```
You are running an automated wiki update. Do the following:

1. Check the raw/ directory for any files that don't have a matching summary in .data/summaries/
2. For each unprocessed file:
   - Create directories if needed: mkdir -p raw wiki index .data/summaries .data/concepts .data/topics .data/insights .data/references .data/drafts
   - Copy/store the raw source
   - Read and understand the content
   - Create a summary in .data/summaries/
   - Extract concepts to .data/concepts/
   - Update topics in .data/topics/
   - Publish polished pages to wiki/
   - Update index files
   - Log to log.md
3. After all ingestion is done, rebuild all indexes:
   - Rebuild index/source-index.md
   - Rebuild index/concept-index.md
   - Rebuild index/master-index.md
4. Log the update to log.md

If there are no new files, just rebuild the indexes and log it.
Be thorough but concise. Commit any changes with a descriptive message.
```

**Create trigger body:**
- `name`: descriptive (e.g. "wiki-update-daily-9am" or "wiki-update-every-2h")
- `cron_expression`: the UTC cron from Step 2
- `enabled`: true
- `environment_id`: `env_016mse8yZT7MKn7BgjjQJoix`
- `sources`: `[{"git_repository": {"url": "https://github.com/bradduy/wiki-knowledge-compiler"}}]`
- `allowed_tools`: `["Bash", "Read", "Write", "Edit", "Glob", "Grep"]`
- `model`: `claude-sonnet-4-6`
- Generate a fresh lowercase v4 UUID for `events[].data.uuid`

### Step 6: Show the result

After creating, show:

```
✓ Schedule created!

  📋 Name: [name]
  ⏰ Runs: [human-readable schedule in user's timezone]
  🆔 ID: [trigger_id]
  🔗 Manage: https://claude.ai/code/scheduled/[trigger_id]

Your wiki will now sync automatically. New files dropped into raw/
will be ingested and indexes rebuilt on schedule.

To change or delete this schedule, visit the link above.
```

### Step 7: Next step menu

```
What would you like to do next?

  1. 📅 Create another schedule                    → /wiki-schedule
  2. 📥 Add a document now                         → /wiki-ingest
  3. 🔍 Ask a question                             → /wiki
  4. ✨ Generate insights                           → /wiki-insights
  5. ✅ I'm done for now

Enter 1-5:
```

Run the command the user picks. If they choose 5, end the session.
