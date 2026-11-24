# Architecture

Project-specific facts an agent can't infer from code or a generic skill. Fill in
what applies, delete the rest. Keep it current: a stale line here is worse than
a missing one.

## Overview

<!-- One paragraph or a small diagram: main parts and how data flows between them. -->

## Runtime constraints

<!-- What the runtime does NOT allow or does differently. Examples:
- Runs on Cloudflare Workers: no Node fs, 128 MB memory, 30 s CPU.
- Tauri: frontend can only call commands granted in src-tauri/capabilities/default.json.
- Bot runs as a single long-polling process; no horizontal scaling.
-->

## Data

- **Database:** <!-- engine + version, where it runs -->
- **Access layer:** <!-- ORM / query builder / raw driver -->
- **Migrations:** <!-- tool + command; who runs it; never edit applied migrations -->
- **Key tables/collections:** <!-- only the ones with non-obvious rules -->

## Contracts

<!-- Interfaces other parts depend on. Changing these needs a matching change on the other side.
- HTTP API: base path, auth header, error shape.
- IPC / Tauri commands / Electron channels: names and payloads.
- Bot callback_data format: domain:action:id.
- Mini App / deep link params.
-->

## Auth and secrets

<!-- How users authenticate, where secrets come from (env names), what must never be logged. -->

## Build, test, deploy

<!-- Anything beyond the Commands block in AGENTS.md: environments, signing, store release steps, CI quirks. -->
