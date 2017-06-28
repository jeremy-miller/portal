[![MIT Licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/hyperium/hyper/master/LICENSE)

# Portals
Transfers data between two colored portals (similar to the [Portal](https://en.wikipedia.org/wiki/Portal_(video_game)) video game).
This project is based on [this](http://howistart.org/posts/elixir/1/) tutorial.
This implementation uses a Docker container to isolate the execution environment.

## Usage
To interact with the portal data transfer system, follow the steps below.

### Prerequisites
- [Docker](https://docs.docker.com/engine/installation/)

### Setup
Before interacting with the portals, the Docker container must be built: ```docker build -t jeremymiller/portal .```

### Test
TBD

### Run
1. To compile the portal application and run the *iex* REPL, execute the following command: ```docker run -it --rm jeremymiller/portal```

2. Once the files compile and the REPL starts you should see an ```iex(1)>``` prompt.
At the prompt, first create two portals by executing the following commands (you can change the colors if you want):
```elixir
iex> Portal.shoot(:orange)
{:ok, #PID<0.72.0>}
iex> Portal.shoot(:blue)
{:ok, #PID<0.74.0>}
```
*NOTE: You may see different PID values, but that is ok.*

3. Now that the portals have been created, we can setup the data transfer using the two colored portals you defined above and some data.
In this example we'll use ```[1, 2, 3, 4]``` as our data to be transferred.
```elixir
iex> portal = Portal.transfer(:orange, :blue, [1, 2, 3, 4])

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

## TODO
- ExUnit tests
- Travis CI
- Coveralls code coverage
- Code Climate
- Dialyzer
- Other tools from Awesome Elixir
