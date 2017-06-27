[![MIT Licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/hyperium/hyper/master/LICENSE)

# Portal
Transfers data between two colored portals (similar to the [Portal](https://en.wikipedia.org/wiki/Portal_(video_game)) video game).  This project is based on [this](http://howistart.org/posts/elixir/1/) tutorial.

## TODO
- ExUnit tests
- Generate ExDoc documentation
- Docker
- Update readme badges
- Build, static analysis, etc

## Usage
```
$ iex -S mix
iex> Portal.shoot(:orange)
{:ok, #PID<0.72.0>}
iex> Portal.shoot(:blue)
{:ok, #PID<0.74.0>}
iex> portal = Portal.transfer(:orange, :blue, [1, 2, 3, 4])

       :orange <=> :blue
  [1, 2, 3, 4] <=> []

iex> Portal.push_data(portal, :right)

    :orange <=> :blue
  [1, 2, 3] <=> [4]

iex> Portal.push_data(portal, :left)

       :orange <=> :blue
  [1, 2, 3, 4] <=> []

```
