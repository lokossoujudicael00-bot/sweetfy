alter table articles
  add column if not exists description text,
  add column if not exists photos text[] default '{}',
  add column if not exists status text default 'en_cours';

create policy "maj" on articles for update to authenticated
  using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "suppr" on articles for delete to authenticated
  using (auth.uid() = user_id);

insert into storage.buckets (id, name, public) values ('photos', 'photos', true)
  on conflict (id) do nothing;
create policy "photos ajout" on storage.objects for insert to authenticated
  with check (bucket_id = 'photos' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "photos suppr" on storage.objects for delete to authenticated
  using (bucket_id = 'photos' and (storage.foldername(name))[1] = auth.uid()::text);
