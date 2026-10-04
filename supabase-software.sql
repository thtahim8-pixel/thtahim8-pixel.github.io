-- Supabase SQL Editor-এ New query খুলে এটা paste করে Run দাও
create table public.software (
  id bigint generated always as identity primary key,
  name text not null,
  description text,
  path text not null,
  filename text not null,
  size bigint,
  created_at timestamptz default now()
);
alter table public.software enable row level security;
create policy "anyone can view software" on public.software for select using (true);
create policy "admin insert software" on public.software for insert to authenticated with check (true);
create policy "admin delete software" on public.software for delete to authenticated using (true);

insert into storage.buckets (id, name, public) values ('software-files','software-files',true);
create policy "admin upload software" on storage.objects for insert to authenticated with check (bucket_id='software-files');
create policy "admin remove software" on storage.objects for delete to authenticated using (bucket_id='software-files');
