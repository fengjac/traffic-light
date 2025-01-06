# build stage
FROM node:22-slim AS build
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable
WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile
COPY . .
RUN pnpm run build


# production stage
FROM node:current-alpine3.19 AS production
ENV appdir /usr/src/app
RUN mkdir -p $appdir
WORKDIR $appdir
COPY --from=build /app/.output $appdir
ENV NODE_ENV=production
# ENV HOST=0.0.0.0
ENV NITRO_PORT=8080

# Expose the port the application will run on
EXPOSE 8080

# Start the application
CMD ["node","server/index.mjs"]
