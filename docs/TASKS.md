# Tasks

## Sprint 1 — DB, Seed Data & Script Generation Engine
**Goal:** The one core action works end-to-end. A brief becomes an AI script persisted in the DB.

- [ ] Run migration SQL (all 4 tables + RLS + seed data)
- [ ] Verify seed scripts render at `/scripts` without login
- [ ] Build `/briefs/new` — brief intake form with validation
- [ ] `POST /api/generate-script` — reads brief, calls OpenAI, inserts generated_script + 3 script_sections + usage_event
- [ ] Build `/scripts/[id]` — fetches script + sections from Supabase, renders Hook / Body / CTA
- [ ] Loading spinner during generation; error toast on failure
- [ ] Empty state on `/scripts` if no scripts exist

**Definition of Done:** Fill brief → click Generate → script appears at `/scripts/[id]` with hook/body/CTA from DB. Usage event row exists. Works with seed data and new submissions.

---

## Sprint 2 — Script Management & Usage Dashboard ✅ v1 FUNCTIONAL
**Goal:** Team can manage scripts and see usage at a glance.

- [ ] `/scripts` list page — all scripts, newest first, with title + created_at + status badge
- [ ] Inline section editing — click section → textarea → save → PATCH to DB → `section_edited` usage event logged
- [ ] Soft-delete script — button → confirm → `is_deleted = true` + `script_deleted` usage event
- [ ] `/usage` dashboard — total scripts generated, scripts this week, event counts by type
- [ ] Copy-to-clipboard on full script text

**Definition of Done:** User can browse, edit, delete scripts and see live usage counts. All state from DB, no dead buttons.

---

## Sprint 3 — Lock It Down (Auth + Per-User Isolation)
**Goal:** Real users can sign up; their data is isolated.

- [ ] Enable Supabase Auth (email + password)
- [ ] Sign-up and login pages at `/auth/signup` and `/auth/login`
- [ ] Set `user_id = auth.uid()` on all new inserts
- [ ] Replace permissive RLS policies with owner-scoped policies
- [ ] Seed demo rows remain readable to anonymous visitors (public demo mode)
- [ ] Redirect unauthenticated users away from write actions (generate, edit, delete)

**Definition of Done:** Two separate accounts cannot see each other's scripts. Seed demo rows still visible publicly.

---

## Sprint 4 — Quality, Versioning & Export
**Goal:** Scripts are production-ready with revision history and export.

- [ ] Regenerate script → new version row, old version preserved and browsable
- [ ] Version selector on script viewer
- [ ] Show confidence score per section; low-confidence sections flagged visually
- [ ] Review status toggle per section (unreviewed → reviewed → approved)
- [ ] "Ready to shoot" badge when all sections approved
- [ ] Export script as .txt and PDF

**Definition of Done:** User can regenerate, compare versions, approve sections, and download a clean script file.

---

## Gantt (Sprint → Feature)
```
Sprint 1: DB schema, seed data, brief form, AI generation API, script viewer
Sprint 2: Scripts list, inline edit, soft-delete, usage dashboard   ← v1 functional
Sprint 3: Auth, sign-up/login, owner RLS, per-user isolation
Sprint 4: Versioning, confidence UI, review status, export
```
