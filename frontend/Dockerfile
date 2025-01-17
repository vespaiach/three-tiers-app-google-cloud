# syntax=docker/dockerfile:1.4


# 1. For build React app
FROM node:lts AS development
ARG VITE_API_BASE_URL
ENV VITE_API_BASE_URL=$VITE_API_BASE_URL
# Set working directory
WORKDIR /app
COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json
# Same as npm install
RUN npm ci
COPY . /app


FROM development AS build
RUN npm run build


FROM development as dev-envs
RUN apt-get update && apt-get install -y --no-install-recommends git
RUN useradd -s /bin/bash -m vscode && groupadd docker && usermod -aG docker vscode
# install Docker tools (cli, buildx, compose)
COPY --from=gloursdocker/docker / /


# 2. For Nginx setup
FROM nginx:alpine
# Copy config nginx
COPY --from=build /app/.nginx/nginx.conf /etc/nginx/conf.d/default.conf
WORKDIR /usr/share/nginx/html
# Remove default nginx static assets
RUN rm -rf ./*
# Copy static assets from builder stage
COPY --from=build /app/dist .
# Containers run nginx with global directives and daemon off
ENTRYPOINT ["nginx", "-g", "daemon off;"]
