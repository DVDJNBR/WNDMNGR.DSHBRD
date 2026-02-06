# Dashboard Handoff - Wind Manager

## Contexte

Ce document résume le travail effectué sur le dashboard Evidence.dev et les raisons du pivot vers SvelteKit.

---

## Ce qui a été réalisé

### Dashboard Evidence fonctionnel

Un dashboard Evidence.dev connecté à Supabase avec:
- Dropdown de sélection de ferme
- Affichage des infos ferme, localisation, statut, turbines, référents
- Déploiement Vercel fonctionnel

### Tables Supabase utilisées

| Table | Description | Rows |
|-------|-------------|------|
| farms | Liste des fermes | 43 |
| farm_types | Types de fermes | 3 |
| farm_locations | Localisation géographique | 41 |
| farm_statuses | Statuts des fermes | 41 |
| farm_turbine_details | Caractéristiques turbines | 41 |
| farm_referents | Référents par ferme | 673 |
| companies | Entreprises | 57 |
| company_roles | Rôles entreprises | 15 |
| persons | Personnes | 53 |
| person_roles | Rôles personnes | 18 |

### Queries SQL réutilisables

```sql
-- Liste des fermes pour dropdown
SELECT uuid, code, project, spv
FROM public.farms
ORDER BY project;

-- Infos ferme avec type
SELECT
    f.code,
    f.project,
    f.spv,
    ft.type_title as farm_type
FROM public.farms f
LEFT JOIN public.farm_types ft ON f.farm_type_id = ft.id
WHERE f.uuid = '{selected_farm_uuid}';

-- Localisation
SELECT country, region, department, municipality, map_reference
FROM public.farm_locations
WHERE farm_uuid = '{selected_farm_uuid}';

-- Statut
SELECT farm_status, tcma_status
FROM public.farm_statuses
WHERE farm_uuid = '{selected_farm_uuid}';

-- Turbines
SELECT turbine_count, manufacturer, hub_height_m, rotor_diameter_m,
       rated_power_installed_mw, total_mmw
FROM public.farm_turbine_details
WHERE wind_farm_uuid = '{selected_farm_uuid}';

-- Référents
SELECT
    COALESCE(p.first_name || ' ' || p.last_name, c.name) as referent_name,
    COALESCE(pr.role_name, cr.role_name) as role
FROM public.farm_referents fr
LEFT JOIN public.persons p ON fr.person_uuid = p.uuid
LEFT JOIN public.companies c ON fr.company_uuid = c.uuid
LEFT JOIN public.person_roles pr ON fr.person_role_id = pr.id
LEFT JOIN public.company_roles cr ON fr.company_role_id = cr.id
WHERE fr.farm_uuid = '{selected_farm_uuid}';
```

---

## Pourquoi on abandonne Evidence

### Problème de sécurité fondamental

Evidence.dev génère des **fichiers statiques** au build:

```
Build time:  Supabase → données → fichiers .parquet sur CDN
Runtime:     Utilisateur → fichiers .parquet (accessibles sans auth)
```

**Les données sont exposées en fichiers statiques**, même avec une auth client-side.
Pour des données sensibles (entreprise + API production), c'est **insuffisant**.

### Limite Cloudflare Pages

Le fichier DuckDB WASM (32.7 MiB) dépasse la limite Cloudflare (25 MiB).
Contournement possible mais complexe (Workers + R2).

---

## Nouveau plan: SvelteKit + Supabase Auth

### Architecture cible

```
SvelteKit (SSR)
├── Supabase Auth (authentification)
├── Supabase RLS (Row Level Security)
├── Cloudflare Pages (hébergement gratuit)
└── Cloudflare Access (optionnel: SSO Entra ID)
```

### Pourquoi c'est mieux

| Aspect | Evidence | SvelteKit SSR |
|--------|----------|---------------|
| Données | Fichiers statiques exposés | Fetch serveur protégé |
| Auth | Non supporté | Supabase Auth natif |
| CRUD | Lecture seule | Create/Read/Update/Delete |
| Sécurité | Insuffisant | RLS + Auth serveur |

### Avantages SvelteKit

- **Dashboard + CRUD** dans une seule app
- **Auth utilisateurs** avec Supabase
- **Rôles/permissions** possibles
- **API custom** si besoin
- **Données jamais exposées** en statique

---

## Configuration Supabase

### Variables d'environnement

```
EVIDENCE_SOURCE__supabase__host=aws-1-eu-west-1.pooler.supabase.com
EVIDENCE_SOURCE__supabase__port=5432
EVIDENCE_SOURCE__supabase__database=postgres
EVIDENCE_SOURCE__supabase__user=postgres.egmwfzmjkpqjpzlcnqya
EVIDENCE_SOURCE__supabase__password=***
EVIDENCE_SOURCE__supabase__ssl=no-verify
```

Pour SvelteKit, utiliser:
```
PUBLIC_SUPABASE_URL=https://egmwfzmjkpqjpzlcnqya.supabase.co
PUBLIC_SUPABASE_ANON_KEY=***
SUPABASE_SERVICE_ROLE_KEY=*** (côté serveur uniquement)
```

### Connection pooling

- **Session pooler** (port 5432) fonctionne mieux que Transaction pooler
- **SSL**: `no-verify` nécessaire pour éviter les erreurs de certificat

---

## Branches Git

| Branche | État | Notes |
|---------|------|-------|
| main | Propre | Base stable |
| SPPRT/DISPLAY_TABLES | Archive | Dashboard Evidence fonctionnel |
| SPPRT/CLOUDFLARE_PAGES_AUTH | Archive | Tentative Cloudflare (limite fichier) |
| SPPRT/SUPABASE_AUTH | Abandonné | Pivot vers autre repo |

---

## Prochaines étapes (autre repo)

1. **Setup SvelteKit** avec adapter-cloudflare
2. **Intégrer Supabase Auth** (login/logout)
3. **Configurer RLS** sur les tables sensibles
4. **Recréer le dashboard** avec les queries ci-dessus
5. **Ajouter CRUD** pour gestion des fermes
6. **Déployer sur Cloudflare Pages**
7. **(Optionnel)** Ajouter Cloudflare Access pour SSO Entra ID

---

## Ressources utiles

- [SvelteKit + Supabase Auth](https://supabase.com/docs/guides/auth/server-side/sveltekit)
- [Cloudflare Pages + SvelteKit](https://developers.cloudflare.com/pages/framework-guides/sveltekit/)
- [Supabase RLS](https://supabase.com/docs/guides/auth/row-level-security)
