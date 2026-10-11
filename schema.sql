-- Run this whole script in Supabase Dashboard → SQL Editor → New query.
-- The website saves one JSON payload per signed-in user in attendance_data.
create table if not exists public.attendance_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null default '{"threshold":75,"records":[],"batch":"A"}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.attendance_data enable row level security;

drop policy if exists "Users can read their own attendance" on public.attendance_data;
create policy "Users can read their own attendance"
on public.attendance_data for select to authenticated
using (auth.uid() = user_id);

drop policy if exists "Users can insert their own attendance" on public.attendance_data;
create policy "Users can insert their own attendance"
on public.attendance_data for insert to authenticated
with check (auth.uid() = user_id);

drop policy if exists "Users can update their own attendance" on public.attendance_data;
create policy "Users can update their own attendance"
on public.attendance_data for update to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);
