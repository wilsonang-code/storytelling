# Intelligence Layer

## Messy Input
Freeform brief fields: topic is a sentence or fragment; key_messages are informal bullets; tone is a user-typed adjective.

## Auto-Structure Schema (what the AI returns)
```json
{
  "hook": "Imagine having every insight before the morning standup.",
  "body": "Our dashboard puts data at your fingertips — no SQL, no delays.",
  "cta": "Start your free trial today.",
  "confidence": 0.91,
  "source": "openai/gpt-4o"
}
```
Each field is stored individually in `script_sections` with its own `confidence` and `review_status`.

## Events to Track
- `script_generated` — brief → script, tokens used, model version
- `section_edited` — which section, before/after length
- `script_regenerated` — new version requested
- `script_exported` — format (txt, PDF)

## Scoring Rules (rule-based v1)
- Confidence < 0.75 → flag section as `needs_review` automatically
- Scripts with all sections `approved` → badge "Ready to shoot"
- Usage count per topic → surfaces most-generated themes in dashboard

## What Gets Ranked (v1)
- Scripts list sorted by `created_at` desc (newest first)
- Sections flagged low-confidence surfaced at top of review queue

## v1 vs Later
**v1:** Rule-based confidence flagging, recency sort
**Later:** LLM-scored script quality (clarity, persuasion, length fit); recommended tone per audience type; auto-suggest missing key messages
