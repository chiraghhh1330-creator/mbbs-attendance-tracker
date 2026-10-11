# MBBS Attendance Tracker — Cloud Login Edition

The attendance tracker now supports real email/password authentication and cloud sync using Supabase. Each signed-in user has a separate attendance record, and their attendance can sync between devices once this site is hosted online.

## One-time setup (phone-friendly)

### 1) Create a free Supabase project
1. Open https://supabase.com in your browser and create an account/project.
2. In your project, open **SQL Editor** → **New query**.
3. Open the included `schema.sql`, copy all its contents into the SQL editor, and press **Run**. This creates the attendance table and security rules so users can only access their own data.

### 2) Add your project's public settings
1. In Supabase, open **Project Settings → API** (or **Connect** and find the API URL and anon/public key).
2. Open `index.html` in a text editor.
3. Near the top of its JavaScript, find:
   ```js
   const SUPABASE_URL = "YOUR_SUPABASE_PROJECT_URL";
   const SUPABASE_ANON_KEY = "YOUR_SUPABASE_ANON_PUBLIC_KEY";
   ```
4. The Project URL is already filled in for your project. Replace only `YOUR_SUPABASE_ANON_PUBLIC_KEY` with your **Publishable key** (starts with `sb_publishable_`). Keep the quotation marks.

**Security:** only use the anon/public key in this website. Never use a `service_role` or secret key in browser code.

### 3) Host the website online
A `file://` page on your phone is not enough for reliable cross-device sync. Publish the files to a static web host:
1. Extract the ZIP on your phone.
2. Upload `index.html` and `schema.sql` (or just `index.html` for the live site) to a static host such as Netlify Drop: https://app.netlify.com/drop . You may need to sign in and upload the extracted site files.
3. Open the published HTTPS website on your phone and another device when needed.

### 4) Set authentication URLs
In Supabase, go to **Authentication → URL Configuration**. Set **Site URL** to your published HTTPS website address. Add that same address under **Redirect URLs** if prompted.

For the simplest setup, under **Authentication → Providers → Email**, you can keep email confirmation enabled (new users must confirm their email before logging in). Check your inbox/spam folder. You may configure email confirmation in Supabase if you prefer a different flow.

## Features kept
- Subject-wise attendance and overall percentage
- Batch A / Batch B schedule
- Today view, timetable, attendance history
- Attendance target calculations
- Import/export backup and reset controls
- Aesthetic mobile-first interface

## Notes
- Cloud records are saved in Supabase and scoped to the signed-in account by Row Level Security.
- The browser keeps a per-account local cache as a convenience; the Supabase database is the cross-device source of truth.
- Keep exporting backups occasionally. The import function replaces the current account's attendance data.
- If you get a database error, confirm that `schema.sql` ran successfully and that you used the correct Supabase URL and anon/public key.
