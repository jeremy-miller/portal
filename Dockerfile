FROM elixir:1.4.5
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY mix.exs /usr/src/app
RUN mix deps.get
COPY . /usr/src/app
CMD ["iex", "-S", "mix"]
