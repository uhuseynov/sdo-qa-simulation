-- Leaderboard for "QA First Day". Run once in Supabase: SQL Editor -> New query -> Run.
create table if not exists public.qa_sim_scores (
  id         bigint generated always as identity primary key,
  nickname   text        not null check (char_length(nickname) between 1 and 16),
  score      integer     not null check (score between 0 and 100),
  created_at timestamptz not null default now()
);

alter table public.qa_sim_scores enable row level security;

-- Everyone may read the leaderboard and add a score, nobody may change or delete scores.
create policy "read scores" on public.qa_sim_scores
  for select to anon using (true);
create policy "add a score" on public.qa_sim_scores
  for insert to anon with check (char_length(nickname) between 1 and 16 and score between 0 and 100);

grant select, insert on public.qa_sim_scores to anon;
