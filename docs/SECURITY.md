# Security

## Secret Handling
- `OPENAI_API_KEY` lives only in Vercel environment variables — never imported into client components
- All AI calls go through Next.js server-side API routes (`/api/generate-script`)
- Supabase service-role key used only in server routes; client uses anon key only

## Permission Model (v1 → lock-down)
- **v1 (demo):** Permissive RLS — all rows readable and writable by anyone; safe because no real user data yet
- **Lock-down sprint:** Replace with `auth.uid() = user_id` owner policies on all tables; anonymous visitors get read-only access to seeded demo rows only

## Approved-Tools Rule
- Agents may only call named tools listed in `AGENTIC_LAYER.md`
- No raw `execute_sql`, `run_any`, or `send_any` calls permitted
- Every tool call that writes data logs a `usage_event` row

## Audit Principle
- Every meaningful write (generate, edit, delete, export) inserts a `usage_event` row
- `usage_events` is append-only — no update or hard-delete policies in lock-down
- Agent actions inherit the authenticated user's permissions; no privilege escalation
