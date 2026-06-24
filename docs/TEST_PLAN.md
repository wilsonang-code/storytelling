# Test Plan

## Core Success Scenario (manual)
1. Open `/` — confirm seed scripts list renders without login
2. Click **New Script Brief** → `/briefs/new`
3. Fill in: Title = "Summer Campaign", Topic = "Our summer sale starts July 1", Tone = "fun and urgent", Audience = "existing customers", Key Messages = "50% off, 3 days only, free shipping"
4. Click **Generate Script** — spinner appears
5. Redirected to `/scripts/[new-id]` — Hook, Body, CTA sections visible
6. Confirm row exists in `generated_scripts` (Supabase table viewer)
7. Confirm 3 rows in `script_sections` with correct `section_type` values
8. Confirm 1 row in `usage_events` with `event_type = 'script_generated'`
9. Click on Body section → edit text → Save → confirm DB updated, `review_status = 'reviewed'`
10. Navigate to `/scripts` → new script appears at top of list
11. Navigate to `/usage` → total count incremented

## Empty State
- Delete all scripts (or test in fresh DB) → `/scripts` shows "No scripts yet. Create your first brief."

## Error Cases
- Submit brief form with missing required field → inline validation message, no API call made
- Simulate OpenAI API failure (invalid key) → error toast "Script generation failed. Please try again.", no partial rows written
- Navigate to `/scripts/nonexistent-id` → 404 message "Script not found"
- Edit section with empty text → save blocked, validation message shown

## Permissions (post Sprint 3)
- Log in as User A, generate a script
- Log in as User B → User A's script not visible in list
- Attempt direct GET to User A's `/scripts/[id]` as User B → 404 or redirect
