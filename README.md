# Sweetify — mise en ligne

Fichiers : index.html (le site), manifest.json + icon.svg (installation sur téléphone).

## 1. Activer les vrais comptes et articles (Supabase, gratuit)
1. Crée un projet sur supabase.com.
2. SQL Editor → colle et exécute :

create table articles(
  id bigint generated always as identity primary key,
  name text, category text, price numeric, used boolean,
  emoji text, seller text,
  user_id uuid default auth.uid(),
  created_at timestamptz default now());
alter table articles enable row level security;
create policy "lecture" on articles for select using (true);
create policy "ajout" on articles for insert to authenticated with check (auth.uid() = user_id);

3. Project Settings → API : copie « Project URL » et la clé « anon public ».
4. Dans index.html, remplis : const SUPA_URL="..." et SUPA_KEY="..." (en haut du script).
5. Authentication → Providers → Email : active (désactive « Confirm email » pour tester vite).
6. Authentication → URL Configuration : mets l'adresse de ton site une fois en ligne.

## 2. Mettre le site en ligne (gratuit)
- Netlify : app.netlify.com/drop → glisse le dossier contenant ces 4 fichiers. Tu obtiens un lien en https.
- Alternative : GitHub + Vercel (même principe, mises à jour automatiques).
- Nom de domaine : achète-le (ex. sweetify.com) puis relie-le dans Netlify > Domain management.

## 3. Sur téléphone
- Site : ouvre le lien dans Chrome (Android) ou Safari (iPhone).
- Application : menu ⋮ (Chrome) > « Installer l'application » / Safari > Partager > « Sur l'écran d'accueil ».
- Vrai fichier APK / Play Store : va sur pwabuilder.com, colle ton lien, télécharge le paquet Android.

## 4. Poster des articles
Crée ton compte sur le site → bouton « ＋ Vendre » → nom, prix, état, catégorie → Publier.
L'article apparaît pour tous les visiteurs.

## 5. Avant de vendre pour de vrai
Le paiement est encore simulé. À brancher : Stripe ou PayPal (carte), et pour l'Afrique de l'Ouest
KKiaPay, FedaPay ou CinetPay (MTN/Moov Mobile Money). Prévois aussi : photos réelles des articles,
mentions légales, conditions de vente.

## 6. Bloc CONFIG (en haut du script de index.html)
Remplace : company, rccm, email, phone, whatsapp, address, hours, feePercent.
Les pages Contact, Mentions légales, Confidentialité et le pied de page se mettent à jour tout seuls.
Les textes des politiques (CGU, confidentialité, cookies, articles interdits) sont des modèles :
fais-les relire par un juriste avant d'ouvrir au public. Ils existent en français et en anglais.

## 7. Paiements (CONFIG.pay)
Colle tes clés PUBLIQUES (jamais les clés secrètes dans index.html) :
- stripeKey : clé publique Stripe (pk_live_...) → cartes, Apple/Google Pay, SEPA
- paypalClientId : Client ID PayPal
- kkiapayKey / fedapayKey / cinetpayKey : clé publique du fournisseur Mobile Money choisi
Tant que tout est vide, le paiement reste simulé. Dès qu'une clé est remplie, complète la fonction
correspondante dans PAYFN (voir « PAIEMENTS » dans le script) avec le code du fournisseur.
Pour Stripe, la session de paiement doit être créée côté serveur (Supabase Edge Function), clé secrète jamais dans le site.
