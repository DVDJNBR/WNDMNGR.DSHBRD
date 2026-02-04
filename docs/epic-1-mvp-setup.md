# Epic-1: MVP Evidence Dashboard Setup - Brownfield Enhancement

## Epic Goal
Initialize the "Wind Manager Dashboard" using Evidence.dev, connect it to the existing Supabase database (containing wind turbine data), and establish a continuous deployment pipeline to Vercel. This serves as the foundation for future data visualizations.

## Epic Description

**Existing System Context:**
- **Functionality:** The system aggregates wind turbine data (currently in Supabase) from various sources (APIs, scraping).
- **Technology Stack:** Supabase (PostgreSQL), Evidence.dev (New Frontend), Vercel (New Hosting).
- **Integration Points:** Evidence connects directly to Supabase via connection string.

**Enhancement Details:**
- **What's being added:** A new Evidence project repository, configuration for Supabase connectivity, and a CI/CD pipeline to Vercel.
- **How it integrates:** Evidence queries Supabase in build time (or run time depending on mode) to generate static sites deployed to Vercel.
- **Success Criteria:** 
  1. A local Evidence app runs and displays data from Supabase.
  2. The app is publicly accessible via a Vercel URL.
  3. Updates to the repo trigger automatic deployments.

## Stories

### Story 1: Initialize Evidence & Connect Supabase
**Description:** Initialize a new Evidence project in the repository and configure the connection to the existing Supabase database.
**Acceptance Criteria:**
- Evidence project structure is created in the root (or a `dashboard` subfolder).
- `CONNECTION_STRING` is configured (using env vars).
- A basic query (e.g., `SELECT * FROM turbines LIMIT 5` - or equivalent existing table) runs successfully.
- A simple page displays this data table.

### Story 2: Deploy to Vercel
**Description:** Configure Vercel to build and deploy the Evidence project.
**Acceptance Criteria:**
- Build settings are configured in Vercel (build command `npm run build`, output dir `build/` or similar).
- Environment variables (Supabase connection) are securely added to Vercel.
- A successful build is deployed to a live URL.
- The live URL displays the data from Story 1.

### Story 3: Basic Turbine Visualization
**Description:** specific data visualization to validate the data pipeline.
**Acceptance Criteria:**
- A generic "Turbines" page is created.
- A simple summary statistic (e.g., Total Power or Count) is displayed.
- A table listing turbines is displayed.

## Compatibility Requirements
- **Existing APIs:** No changes to Supabase schema required yet.
- **Database:** Read-only access for Evidence (best practice) or restricted user.
- **UI:** Standard Evidence themes.

## Risk Mitigation
- **Primary Risk:** Connection issues or build timeouts on Vercel.
- **Mitigation:** Test build command locally first (`npm run build`). Use Vercel logs to debug.
- **Rollback Plan:** Revert git commits; delete Vercel project if needed.

## Definition of Done
- [ ] Evidence project committed to repo.
- [ ] Local build passes.
- [ ] Vercel deployment is green.
- [ ] Data is visible on the live site.
