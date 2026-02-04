# WPD Wind Manager Dashboard

Dashboard de visualisation des données éoliennes pour WPD Windmanager France, construit avec [Evidence.dev](https://evidence.dev/).

## Stack Technique

- **Frontend**: Evidence.dev (framework de BI basé sur Markdown + SQL)
- **Base de données**: Supabase (PostgreSQL)
- **Hébergement**: Cloudflare Pages

## Structure du Projet

```
├── dashboard/           # Application Evidence.dev
│   ├── pages/          # Pages Markdown avec requêtes SQL
│   ├── sources/        # Configuration des sources de données
│   └── package.json
├── docs/               # Documentation du projet
└── bmad-agent/         # Configuration BMAD
```

## Deployment

### Vercel (Recommended)

This project is configured for deployment on Vercel.

1.  Push your code to a Git repository (GitHub, GitLab, Bitbucket).
2.  Import the project into Vercel.
3.  Vercel should automatically detect the settings (Framework: Other/SvelteKit, Build Command: `npm run build`, Output Directory: `build`).
4.  Add your Supabase environment variables in the Vercel project settings (`Settings` > `Environment Variables`).

### Local Development

1.  Navigate to the `dashboard` directory: `cd dashboard`
2.  Install dependencies: `npm install`
3.  Start the development server: `npm run dev`

## Documentation

- [Epic 1 - MVP Setup](docs/epic-1-mvp-setup.md)
- [Sprint Change Proposal](Sprint_Change_Proposal.md)
