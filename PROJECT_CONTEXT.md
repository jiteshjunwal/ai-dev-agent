# AI Dev Agent – Project Context

## 🎯 Goal
Build a Claude-code-like autonomous coding agent that:
- Takes prompts
- Generates code
- Saves files
- Runs automatically via GitHub Actions
- Deploys apps

---

## ⚙️ Current Architecture

### Local Setup
- `prompt.txt` → input instruction
- `run_agent.sh` → core execution script
- `index.html` (target output)

### AI Provider
- Provider: Groq
- Model: llama-3.1-8b-instant

---

## 🔁 Agent Flow

1. Read prompt from `prompt.txt`
2. Call Groq API using curl
3. Save raw response → `output/result.json`
4. Extract code using `jq`
5. Save output → `index.html`

---

## ☁️ GitHub Automation

- Platform: GitHub Actions
- Trigger: change in `prompt.txt`

### Workflow Steps:
1. Checkout repo
2. Install jq
3. Run `run_agent.sh`
4. Commit generated output

---

## ✅ Completed Fixes

- Fixed API issues (moved to Groq)
- Updated model (deprecation handled)
- Fixed script bugs (curl typo, permissions)
- Implemented JSON parsing using jq
- Fixed GitHub Actions (exit code 128, permissions)

---

## 🚀 Next Steps

- [ ] Save output as `index.html`
- [ ] Auto-deploy on Vercel
- [ ] Improve prompt → enforce clean code output
- [ ] Multi-file generation (HTML, CSS, JS split)
- [ ] Build iterative agent (edit existing files)

---

## 🧠 Notes

- Keep prompts strict: "ONLY code, no explanation"
- Keep outputs deterministic and clean
- Avoid over-complicating infra early

---

## 📌 Current Status

Agent is working locally + via GitHub Actions..
Next milestone: generate deployable web app (`index.html`)