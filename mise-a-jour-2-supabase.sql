-- 1) Adresse privée du vendeur
create table if not exists profiles(
  user_id uuid primary key default auth.uid(),
  address text,
  updated_at timestamptz default now());
alter table profiles enable row level security;
create policy "profil lecture" on profiles for select to authenticated using (auth.uid() = user_id);
create policy "profil ajout" on profiles for insert to authenticated with check (auth.uid() = user_id);
create policy "profil maj" on profiles for update to authenticated using (auth.uid() = user_id);

-- 2) Commandes (notifications vendeur, instructions de paiement, reçu)
create table if not exists orders(
  id bigint generated always as identity primary key,
  article_id bigint, article_name text, photo text, qty int default 1,
  price_txt text, ship_txt text, total_txt text,
  method text, pay_info text,
  seller_id uuid, seller_name text, seller_address text,
  buyer_id uuid default auth.uid(), buyer_name text, buyer_email text,
  buyer_phone text, buyer_address text,
  status text default 'attente_vendeur',
  created_at timestamptz default now(), paid_at timestamptz);
alter table orders enable row level security;
create policy "cmd lecture" on orders for select to authenticated
  using (auth.uid() in (buyer_id, seller_id));
create policy "cmd ajout" on orders for insert to authenticated
  with check (auth.uid() = buyer_id);
create policy "cmd maj" on orders for update to authenticated
  using (auth.uid() in (buyer_id, seller_id));
