#!/bin/sh
redis-server &  # Run Redis
pnpm run start:production &  # Run the server
pnpm run worker:production   # Run the worker
wait  # Waits for subprocesses to finish