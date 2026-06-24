# Data Model

## script_briefs
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | gen_random_uuid() |
| user_id | uuid nullable | owner, set at lock-down |
| title | text | e.g. "Product Launch Teaser" |
| topic | text | one-sentence subject |
| tone | text | e.g. energetic, warm, confident |
| audience | text | target viewer description |
| key_messages | text[] | 2–5 bullet points |
| created_at | timestamptz | default now() |

## generated_scripts
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| brief_id | uuid FK → script_briefs | |
| version | integer | starts at 1, increments on regen |
| full_script | text | **AI field** |
| full_script_source | text | e.g. `openai/gpt-4o` |
| full_script_confidence | numeric | 0–1 |
| full_script_review_status | text | `unreviewed` / `reviewed` / `approved` |
| is_deleted | boolean | soft-delete |
| created_at | timestamptz | |

## script_sections
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| script_id | uuid FK → generated_scripts | |
| section_type | text | `hook` / `body` / `cta` |
| content | text | **AI field** — editable |
| content_source | text | AI model identifier |
| content_confidence | numeric | 0–1 |
| content_review_status | text | `unreviewed` / `reviewed` / `approved` |
| sort_order | integer | render order |
| created_at | timestamptz | |

## usage_events
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| event_type | text | `script_generated`, `section_edited`, `script_deleted`, `script_exported` |
| script_id | uuid nullable | |
| brief_id | uuid nullable | |
| metadata | jsonb | model, tokens, export format, etc. |
| created_at | timestamptz | |

## RLS
All tables: RLS enabled. v1 policies are fully permissive (demo-first). Lock-down sprint replaces with `auth.uid() = user_id` owner policies.
