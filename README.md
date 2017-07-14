[![Build Status](https://travis-ci.org/jeremy-miller/portals.svg?branch=master)](https://travis-ci.org/jeremy-miller/portals)
[![Coverage Status](https://coveralls.io/repos/github/jeremy-miller/portals/badge.svg?branch=master)](https://coveralls.io/github/jeremy-miller/portals?branch=master)
[![Code Climate](https://codeclimate.com/github/jeremy-miller/portals/badges/gpa.svg)](https://codeclimate.com/github/jeremy-miller/portals)
[![MIT Licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/hyperium/hyper/master/LICENSE)
[![Elixir Version](https://img.shields.io/badge/Elixir-1.4-blue.svg)]()

# Portals
Transfers data between two colored portals (similar to the [Portal](https://en.wikipedia.org/wiki/Portal_(video_game)) video game).
This project is based on [this](http://howistart.org/posts/elixir/1/) tutorial.

## Usage
This implementation uses a Docker container to isolate the execution environment.

### Prerequisites
- [Docker](https://docs.docker.com/engine/installation/)

### Setup
Before interacting with the portals, the Docker container must be built: ```docker build -t jeremymiller/portals .```

### Static Code Analysis
To run the [Credo](https://github.com/rrrene/credo) static code analyzer, execute the following command: ```docker run -it --rm jeremymiller/portals mix credo```

To run the [Dialyzer](http://erlang.org/doc/man/dialyzer.html) static code analyzer, execute the following command: ```docker run -it --rm jeremymiller/portals mix dialyzer```
*NOTE: The first time this command is run it may take a long time since it needs to create the PLT (see [here](https://github.com/jeremyjh/dialyxir#usage) for more information).*

### Test
To run the Portal tests, execute the following command: ```docker run -it --rm jeremymiller/portals mix test```

### Run
1. To compile the portal application and run the *iex* REPL, execute the following command: ```docker run -it --rm jeremymiller/portals```

2. Once the files compile and the REPL starts you should see an ```iex(1)>``` prompt.
At the prompt, first create two portals by executing the following commands (you can change the colors if you want):
```elixir
iex> Portal.create(:orange)
{:ok, #PID<0.72.0>}
iex> Portal.create(:blue)
{:ok, #PID<0.74.0>}
```
*NOTE: You may see different PID values, that is ok.*

3. Now that the portals have been created, we can setup the data transfer using the two colored portals you defined above and some data.
In this example we'll use ```[1, 2, 3, 4]``` as our data to be transferred.
```elixir
iex> portal = Portal.setup(:orange, :blue, [1, 2, 3, 4])

       :orange <=> :blue
  [1, 2, 3, 4] <=> []

```

4. Once the transfer has been setup, you can use ```Portal.push_data(portal, :right)``` or ```Portal.push_data(portal, :left)```
to transfer data between the portals.
```elixir
iex> Portal.push_data(portal, :right)

    :orange <=> :blue
  [1, 2, 3] <=> [4]

iex> Portal.push_data(portal, :left)

       :orange <=> :blue
  [1, 2, 3, 4] <=> []

```

## License
[MIT](https://github.com/jeremy-miller/portals/blob/master/LICENSE)
