create table if not exists script_briefs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  title text not null,
  topic text not null,
  tone text not null,
  audience text not null,
  key_messages text[],
  created_at timestamptz not null default now()
);
alter table script_briefs enable row level security;
drop policy if exists "script_briefs_v1_read" on script_briefs;
create policy "script_briefs_v1_read" on script_briefs for select using (true);
drop policy if exists "script_briefs_v1_write" on script_briefs;
create policy "script_briefs_v1_write" on script_briefs for all using (true) with check (true);

create table if not exists generated_scripts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  brief_id uuid references script_briefs(id),
  version integer not null default 1,
  full_script text,
  full_script_source text,
  full_script_confidence numeric,
  full_script_review_status text default 'unreviewed',
  is_deleted boolean not null default false,
  created_at timestamptz not null default now()
);
alter table generated_scripts enable row level security;
drop policy if exists "generated_scripts_v1_read" on generated_scripts;
create policy "generated_scripts_v1_read" on generated_scripts for select using (true);
drop policy if exists "generated_scripts_v1_write" on generated_scripts;
create policy "generated_scripts_v1_write" on generated_scripts for all using (true) with check (true);

create table if not exists script_sections (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  script_id uuid references generated_scripts(id),
  section_type text not null,
  content text not null,
  content_source text,
  content_confidence numeric,
  content_review_status text default 'unreviewed',
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);
alter table script_sections enable row level security;
drop policy if exists "script_sections_v1_read" on script_sections;
create policy "script_sections_v1_read" on script_sections for select using (true);
drop policy if exists "script_sections_v1_write" on script_sections;
create policy "script_sections_v1_write" on script_sections for all using (true) with check (true);

create table if not exists usage_events (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  event_type text not null,
  script_id uuid,
  brief_id uuid,
  metadata jsonb,
  created_at timestamptz not null default now()
);
alter table usage_events enable row level security;
drop policy if exists "usage_events_v1_read" on usage_events;
create policy "usage_events_v1_read" on usage_events for select using (true);
drop policy if exists "usage_events_v1_write" on usage_events;
create policy "usage_events_v1_write" on usage_events for all using (true) with check (true);

insert into script_briefs (id, title, topic, tone, audience, key_messages) values
  ('a1000000-0000-0000-0000-000000000001', 'Product Launch Teaser', 'Launching our new analytics dashboard', 'energetic and inspiring', 'startup founders and product teams', array['10x faster insights', 'no-code setup', 'free trial available']),
  ('a1000000-0000-0000-0000-000000000002', 'Team Culture Story', 'Why our team values async-first work', 'warm and authentic', 'potential hires and partners', array['autonomy drives creativity', 'results over hours', 'global team, one mission']),
  ('a1000000-0000-0000-0000-000000000003', 'Customer Success Spotlight', 'How Acme Corp cut churn by 40%', 'confident and data-driven', 'B2B SaaS decision makers', array['real customer story', '40% churn reduction', 'implemented in 2 weeks']);

insert into generated_scripts (id, brief_id, version, full_script, full_script_source, full_script_confidence, full_script_review_status) values
  ('b1000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 1, 'Hook: Imagine having every insight your team needs before the morning standup. Body: Our new analytics dashboard puts actionable data at your fingertips — no SQL, no waiting, no guesswork. Set up in minutes, not months. CTA: Start your free trial today and see the difference in your first week.', 'openai/gpt-4o', 0.91, 'unreviewed'),
  ('b1000000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000002', 1, 'Hook: What if your best work happened at 2pm in Bali or 9am in Berlin? Body: We are an async-first team that believes creativity thrives when you control your hours. Our people ship great work because they own their time. CTA: Explore open roles and join a team that trusts you.', 'openai/gpt-4o', 0.88, 'reviewed'),
  ('b1000000-0000-0000-0000-000000000003', 'a1000000-0000-0000-0000-000000000003', 1, 'Hook: Acme Corp was losing customers. Then everything changed. Body: In just two weeks, Acme implemented our platform and reduced churn by 40%. Real data. Real results. Real impact. CTA: Book a demo and see how your numbers can look like theirs.', 'openai/gpt-4o', 0.94, 'approved');

insert into script_sections (script_id, section_type, content, content_source, content_confidence, content_review_status, sort_order) values
  ('b1000000-0000-0000-0000-000000000001', 'hook', 'Imagine having every insight your team needs before the morning standup.', 'openai/gpt-4o', 0.92, 'unreviewed', 1),
  ('b1000000-0000-0000-0000-000000000001', 'body', 'Our new analytics dashboard puts actionable data at your fingertips — no SQL, no waiting, no guesswork. Set up in minutes, not months.', 'openai/gpt-4o', 0.90, 'unreviewed', 2),
  ('b1000000-0000-0000-0000-000000000001', 'cta', 'Start your free trial today and see the difference in your first week.', 'openai/gpt-4o', 0.91, 'unreviewed', 3),
  ('b1000000-0000-0000-0000-000000000002', 'hook', 'What if your best work happened at 2pm in Bali or 9am in Berlin?', 'openai/gpt-4o', 0.89, 'reviewed', 1),
  ('b1000000-0000-0000-0000-000000000002', 'body', 'We are an async-first team that believes creativity thrives when you control your hours. Our people ship great work because they own their time.', 'openai/gpt-4o', 0.87, 'reviewed', 2),
  ('b1000000-0000-0000-0000-000000000002', 'cta', 'Explore open roles and join a team that trusts you.', 'openai/gpt-4o', 0.88, 'reviewed', 3),
  ('b1000000-0000-0000-0000-000000000003', 'hook', 'Acme Corp was losing customers. Then everything changed.', 'openai/gpt-4o', 0.95, 'approved', 1),
  ('b1000000-0000-0000-0000-000000000003', 'body', 'In just two weeks, Acme implemented our platform and reduced churn by 40%. Real data. Real results. Real impact.', 'openai/gpt-4o', 0.93, 'approved', 2),
  ('b1000000-0000-0000-0000-000000000003', 'cta', 'Book a demo and see how your numbers can look like theirs.', 'openai/gpt-4o', 0.94, 'approved', 3);

insert into usage_events (event_type, script_id, brief_id, metadata) values
  ('script_generated', 'b1000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', '{"model":"gpt-4o","tokens":312}'),
  ('script_generated', 'b1000000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000002', '{"model":"gpt-4o","tokens":289}'),
  ('script_generated', 'b1000000-0000-0000-0000-000000000003', 'a1000000-0000-0000-0000-000000000003', '{"model":"gpt-4o","tokens":301}');