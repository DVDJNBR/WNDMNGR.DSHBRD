# Sprint Change Proposal: Hosting Pivot to Vercel

## 1. Identified Issue Summary
**Trigger:** Deployment Failure on Cloudflare Pages.
**Issue:** The Evidence framework's core binary (`duckdb-eh.wasm`, ~32MB) exceeds Cloudflare Pages' free tier file size limit of 25MB.
**Rationale:** Compacting the binary is complex and unstable. Switching to a hosting provider with higher limits is the most efficient solution to maintain momentum.

## 2. Epic & Artifact Impact
- **`docs/epic-1-mvp-setup.md`:**
  - **Story 2 (Deploy to Cloudflare Pages):** Needs to be replaced with "Deploy to Vercel".
  - **Risk Mitigation:** Update specific deployment risks (Vercel is generally more permissive for this stack).
  - **Definition of Done:** Update "Cloudflare deployment" criteria to "Vercel deployment".
- **`dashboard/package.json`:**
  - The build script `npm run sources && evidence build` is compatible with Vercel and can be kept.

## 3. Recommended Path Forward
**Path:** **Option 1: Direct Adjustment.**
The architecture remains the same (Client-side WASM + Supabase). Only the hosting "container" changes.
**Target Host:** **Vercel** (Hobby Plan).
- Supports file sizes up to 100MB+.
- Provides 6,000 build minutes/month (sufficient for data updates).

## 4. High-Level Action Plan
1.  **Documentation:** Update Epic 1 to reflect Vercel as the deployment target.
2.  **Implementation:**
    -   Connect the GitHub repository to a new Vercel project.
    -   Configure Environment Variables (`CONNECTION_STRING`) in Vercel.
    -   Verify successful build and deployment.

## 5. Agent Handoff Plan
- **PM:** Update Epic documentation.
- **Dev:** Perform the Vercel linkage and verify the deployment.

---
**Proposed Edits to `docs/epic-1-mvp-setup.md`:**

**Global Replace:**
- `Cloudflare Pages` -> `Vercel`
- `Cloudflare` -> `Vercel`

**Story 2 Update:**
- **Title:** Deploy to Vercel
- **Description:** Connect the repository to Vercel to build and deploy the Evidence project.
- **Acceptance Criteria:**
  - Project connected in Vercel.
  - Env vars (Supabase) configured.
  - Live URL accessible.

---
**Status:** Awaiting User Confirmation to Apply.