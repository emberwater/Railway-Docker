# Railway Deploy (API with Dockerfile + Volume)

This pack gives you a working Dockerfile for the **server/** API so Railway deploys cleanly and your path issues go away.

## Files
- `server/Dockerfile` — pins Node 20 (Debian) and installs build tools for better-sqlite3.
- `server/.dockerignore` — keeps the image small.

## Steps (API service)

1) Commit these files into your repo under **server/**.
2) In Railway → **New → Service → Deploy from Repo**:
   - Choose your repo
   - **Root Directory:** `server/`
   - Railway will auto-detect the Dockerfile and build from it.
3) **Storage → Add Volume**:
   - Mount path: `/data`
4) **Variables** (Service → Variables):
   - `DB_PATH=/data/batchboss.db`
   - `JWT_SECRET=<long-random-string>`
   - `CORS_ORIGIN=https://<your-web-service-domain>`
   - (Do **NOT** set `PORT` — Railway injects it.)
5) Deploy. After it’s live:
   - Healthcheck: `curl -s https://<your-api>.railway.app/health` → `{"ok":true}`

## Steps (Web service)

Option A — Static Site (recommended):
- **New → Static Site** (same repo)
- **Root Directory:** `web/`
- **Build Command:** `npm run build`
- **Publish Directory:** `dist`
- **Env Vars:** `VITE_API_URL=https://<your-api>.railway.app`

Option B — Generic Service:
- **Root Directory:** `web/`
- **Build Command:** `npm run build`
- **Start Command:** `npm start` (ensure web/package.json has: `start: vite preview --port $PORT --strictPort`)
- **Env Vars:** `VITE_API_URL=https://<your-api>.railway.app`

## Troubleshooting
- **Network process failed / never bound to port**: remove any custom `PORT` var; the server listens on Railway’s injected PORT.
- **better-sqlite3 build errors**: Debian Node base + `python3 g++ make` in Dockerfile fixes it.
- **Cannot find module '/app/src/server.js'**: Docker sets `WORKDIR /app/server`, so `node src/server.js` resolves correctly.
- **CORS error in browser**: set `CORS_ORIGIN` on the API to your web URL and redeploy the API.
