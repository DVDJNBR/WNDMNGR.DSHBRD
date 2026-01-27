---
title: Metabase Dashboard
emoji: 📊
colorFrom: blue
colorTo: indigo
sdk: docker
pinned: false
app_port: 3000
---

# Metabase Dashboard on Hugging Face Spaces

This repository hosts a deployment of [Metabase](https://www.metabase.com/), a leading open-source business intelligence tool, on Hugging Face Spaces. It provides a powerful, user-friendly interface for data exploration and dashboarding, serving as an open-source alternative to proprietary solutions like Power BI.

## Getting Started

To launch your Metabase instance:

1.  **Clone this repository** to your Hugging Face Space or create a new Space pointing to this repository.
2.  The `Dockerfile` will automatically build and run the latest Metabase image.
3.  Once the Space is built and running, your Metabase instance will be accessible via the Space URL.

## ⚠️ Important: Data Persistence

By default, Metabase uses an embedded H2 database to store its configuration (users, dashboards, questions). If this Space restarts or is rebuilt, all data stored in the H2 database will be **lost**.

For production use and to ensure your dashboards and configurations are permanent, it is **highly recommended** to connect Metabase to an external PostgreSQL database. Your existing Supabase database is an ideal candidate for this purpose.

### Recommended Persistence Configuration (using Supabase)

To enable persistent storage for Metabase's internal data, configure the following environment variables in your Hugging Face Space settings:

-   `MB_DB_TYPE`: `postgres`
-   `MB_DB_DBNAME`: `postgres` (or your specific Supabase database name)
-   `MB_DB_PORT`: `5432` (standard PostgreSQL port)
-   `MB_DB_USER`: Your Supabase database username
-   `MB_DB_PASS`: Your Supabase database password
-   `MB_DB_HOST`: Your Supabase database host (e.g., `db.your-project-ref.supabase.co`)

Once these variables are set, Metabase will use your Supabase instance to store its metadata, ensuring your work is saved across restarts.

## Features

-   **Interactive Dashboards:** Create and share dynamic dashboards from your Supabase data.
-   **SQL Editor:** Write and execute SQL queries directly against your database.
-   **Visualizations:** A wide array of chart types to visualize your data effectively.
-   **No-Code Interface:** Explore data without writing a single line of code.

## Contribute

Feel free to fork this repository, improve the deployment configuration, or contribute to the Metabase project directly.
