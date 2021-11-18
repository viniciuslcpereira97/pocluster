FROM hexpm/elixir:1.12.3-erlang-24.1.1-alpine-3.14.0 AS build

# setup app
WORKDIR /app

# install hex and rebar
RUN mix do local.hex --force, local.rebar --force

# get mix dependencies
COPY . ./
RUN mix deps.get

# compile dependencies
RUN mix deps.compile

# compile app
RUN mix do compile --warnings-as-errors, release


# PRODUCTION
FROM alpine:3.12 AS production

# install dependencies
RUN apk upgrade --no-cache && \
  apk add ncurses-libs curl libgcc libstdc++

# setup app
WORKDIR /app
COPY --from=build /app/_build/dev/rel/pocluster_umbrella ./

ARG CONTAINER_IP

ENV RELEASE_NODE=cache@$CONTAINER_IP
ENV RELEASE_DISTRIBUTION=name
ENV RELEASE_COOKIE=cluster_cookie

# start application
CMD ["bin/pocluster_umbrella", "start_iex"]