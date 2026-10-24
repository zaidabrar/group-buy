#!/usr/bin/env bash
# One-time setup for Codespaces / dev containers: install deps, write .env, create and seed the database.
set -euo pipefail

npm ci

if [ ! -f .env ]; then
  cp .env.example .env
  sed -i "s|^DATABASE_URL=.*|DATABASE_URL=postgres://postgres:postgres@db:5432/groupcar|" .env
  sed -i "s|^SESSION_SECRET=.*|SESSION_SECRET=$(head -c 48 /dev/urandom | base64 | tr -d '\n/+=')|" .env
fi

# Wait for the Postgres container to accept connections.
for _ in $(seq 1 30); do
  node -e "new (require('pg').Client)({connectionString:'postgres://postgres:postgres@db:5432/groupcar'}).connect().then(()=>process.exit(0),()=>process.exit(1))" && break
  sleep 2
done

npm run db:migrate
npm run db:seed
