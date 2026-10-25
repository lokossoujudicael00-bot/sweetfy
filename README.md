# Sweetify : mise en ligne de A à Z

Fichiers : index.html, config.js, manifest.json, icon.svg, sweetify-sql-complet.sql

## 1. Supabase (une fois, puis à chaque mise à jour du SQL)
1. supabase.com > ton projet > SQL Editor.
2. Efface tout le texte de l'éditeur (Ctrl+A puis Suppr). Désactive la traduction du navigateur.
3. Ouvre sweetify-sql-complet.sql, copie TOUT, colle, clique Run. Résultat attendu : « Success ».
   Ce script peut être relancé sans risque. Si tu vois « relation already exists », c'est que tu as collé un ancien script.
4. Authentication > Providers > Email : désactive « Confirm email » (sinon les inscriptions attendent un email).
5. Project Settings > API : copie « Project URL » et la clé « anon public ».

## 2. config.js
Ouvre config.js, colle l'URL dans SUPA_URL et la clé dans SUPA_KEY, vérifie tes coordonnées. Enregistre.

## 3. GitHub
Dépôt > Add file > Upload files : glisse index.html, config.js, manifest.json, icon.svg > Commit.
Vérifie que les noms n'ont pas de « -2 » ou « (1) ».

## 4. Vercel
Il redéploie tout seul. Ouvre le lien, recharge avec Ctrl+F5.

## 5. Test
Deux comptes sur deux téléphones : A publie un article avec photos, B le voit. B commande, A reçoit la notification,
envoie ses instructions de paiement, B envoie sa preuve, A confirme, les deux voient le reçu.
Si une bannière orange ou rouge s'affiche en haut, elle donne la cause (clés manquantes, SQL non lancé).
