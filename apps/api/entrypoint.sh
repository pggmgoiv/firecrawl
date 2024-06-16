#!/bin/sh
pnpm run start:production &  # Run the server
pnpm run worker:production   # Run the worker
wait  # Waits for subprocesses to finish