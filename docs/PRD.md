# PRD — Storytelling: AI Video Script Platform

## Problem
The team has no structured way to go from a story idea to a production-ready AI video script. Briefs live in Slack, tone is inconsistent, and there is no record of what was generated or how well it performed.

## Target User
Internal team members who need to turn a topic or campaign idea into a structured, ready-to-shoot video script — fast.

## Core Objects
- **Script Brief** — the input: title, topic, tone, audience, key messages
- **Generated Script** — the AI output, versioned, tied to a brief
- **Script Section** — hook / body / CTA segments with AI metadata
- **Usage Event** — every generation, edit, export, and delete action logged

## MVP Checklist (v1 must-haves)
- [ ] Brief intake form that saves to the database
- [ ] AI script generation from brief → structured hook / body / CTA output
- [ ] Script viewer that renders sections from DB
- [ ] Inline section editing that persists changes
- [ ] Usage event logged on every generation
- [ ] Scripts list page (all scripts, newest first)
- [ ] Demo seed data visible without login
- [ ] Empty state, loading, and error handling on all actions

## Non-Goals (v1)
- Direct AI video rendering or export to video platform
- Storyboard or visual asset management
- Comments, mentions, or real-time collaboration
- Billing, quotas, or usage limits
- Public-facing pages or embeds

## Success Criteria
A team member opens the app, fills in a brief for a new product launch video, clicks **Generate Script**, and within 10 seconds sees a structured hook / body / CTA script persisted in the database — which they can edit section by section and return to later.
