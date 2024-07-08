FROM node:20-slim AS base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
LABEL fly_launch_runtime="Node.js"
RUN corepack enable
COPY . /app
WORKDIR /app

FROM base AS prod-deps
RUN mkdir -p /pnpm/store \
    && pnpm install --prod --frozen-lockfile

FROM base AS build
RUN mkdir -p /pnpm/store \
    && pnpm install --frozen-lockfile

RUN pnpm install
RUN pnpm run build

# Install packages needed for deployment
FROM base
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install ca-certificates && \
    apt-get install --no-install-recommends -y chromium chromium-sandbox && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives
COPY --from=prod-deps /app/node_modules /app/node_modules
COPY --from=build /app /app

# Start the server by default, this can be overwritten at runtime
EXPOSE $PORT
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

