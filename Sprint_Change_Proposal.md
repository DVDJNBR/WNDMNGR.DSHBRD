# Sprint Change Proposal: Pivot to Evidence on Cloudflare

## 1. Identified Issue Summary
**Trigger:** Strategic decision to change the dashboarding technology.
**Issue:** The project was initially targeting Google Looker Studio connected to Supabase. The user now wants to switch to **Evidence.dev** (Evidence), hosted on **Cloudflare**, while retaining **Supabase** as the database.
**Rationale:** Evidence offers a code-driven (BI-as-Code) approach which likely aligns better with the user's workflow or requirements than Looker Studio.

## 2. Epic & Artifact Impact
- **Existing Artifacts:**
  - `guide_looker_supabase.md`: **OBSOLETE**. This guide connects Supabase to Looker Studio and is no longer relevant.
  - *No other formal PRD or Architecture docs were found.*
- **New Requirements:**
  - Need to define the architecture for **Evidence + Supabase + Cloudflare**.
  - Need to set up the Evidence project structure.

## 3. Recommended Path Forward
**Path:** **Option 3: Re-scoping / Fresh Start.**
Since the project is in early stages (only a guide existed), we will treat this as a "re-initialization" of the tech stack.

## 4. High-Level Action Plan
1.  **Cleanup:** Archive or delete `guide_looker_supabase.md` to avoid confusion.
2.  **Documentation:** Create a lightweight **Project Brief** or **Mini-PRD** to formally document the new stack (Evidence, Supabase, Cloudflare) and the goal (Wind Manager Dashboard).
3.  **Implementation (Next Steps):**
    -   Initialize a new Evidence project.
    -   Configure the Supabase connection in Evidence.
    -   Set up deployment to Cloudflare Pages.

## 5. Agent Handoff Plan
- **PM (Me):** I will archive the old guide and can help draft the new Project Brief.
- **Developer/Architect:** Will handle the actual installation of Evidence (`npx degit evidence-dev/template`), Supabase connection config, and Cloudflare setup.

---
**Status:** Awaiting Final User Approval.
