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
RUN mix compile --warnings-as-errors
