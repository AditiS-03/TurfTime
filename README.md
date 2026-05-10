# TurfTime - Sports Facility Booking System

This is a modern React + Tailwind CSS web application. It includes dummy data fallback while Supabase is being configured.

## Prerequisites
- Node.js installed

## Quick Start
1. Install dependencies:
   ```bash
   npm install
   ```

2. Configure Environment:
   Create a `.env.local` file in the root directory:
   ```
   VITE_SUPABASE_URL=your_supabase_project_url
   VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
   ```

3. Setup Database:
   - Go to Supabase SQL editor
   - Copy the contents of `supabase_schema.sql` and run it to create tables and policies.

4. Start Development Server:
   ```bash
   npm run dev
   ```

## Stack
- React + Vite
- Tailwind CSS (with custom theme)
- Supabase (Auth + DB)
- React Router DOM
- Lucide React (Icons)
