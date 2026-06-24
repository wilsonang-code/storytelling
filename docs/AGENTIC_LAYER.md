# Agentic Layer

## Risk Levels & Actions

### Low Risk — Auto-execute
- **generate_script_draft** — call OpenAI with brief, insert script + sections, log usage event
- **tag_section_confidence** — parse AI response confidence, set `review_status = 'unreviewed'` or `'needs_review'`
- **log_usage_event** — insert row into `usage_events` on any meaningful action

### Medium Risk — Light approval (user confirms)
- **regenerate_script** — create new version from same brief, increment version counter
- **mark_script_approved** — set all sections to `review_status = 'approved'`

### High Risk — Always approval
- **export_script** — write/download file; user must confirm format and destination

### Critical — Human only
- **delete_script** — soft-delete only; hard delete requires manual DB action

## Named Tools (approved)
- `tool_generate_script(brief_id)` → calls OpenAI, writes to DB
- `tool_update_section(section_id, content)` → patches content, logs edit event
- `tool_log_event(event_type, metadata)` → inserts usage_event
- `tool_export_script(script_id, format)` → generates download

## Audit Log Fields (usage_events)
`id, user_id, event_type, script_id, brief_id, metadata (model/tokens/format), created_at`

## v1 vs Later
**v1:** generate_script_draft + log_usage_event run automatically on form submit
**Later:** Agent proactively suggests regeneration when confidence < 0.75; recommends tone based on past high-rated scripts
