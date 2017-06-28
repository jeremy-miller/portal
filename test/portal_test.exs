defmodule PortalTest do
  use ExUnit.Case, async: true

  # Only output to stdout if there are errors.
  @moduletag :capture_log

  test "the truth" do
    assert 1 + 1 == 2
  end
end
