defmodule Octopus do
  @moduledoc """
  Octopus provides functionality to help you mapping stuff into other stuff
  without the need to write complex or ugly code.
  """

  @type mapper :: (any() -> any())

  @doc """
  Maps any value (not just enumerable!) using a 1-arity mapper function into
  any other value.

  This function is not built using rocket science. It just passes the given
  value as first argument to the given mapper function and returns its result.
  That's all!

  Especially when using the pipe operator `|>`, using `map/2` becomes really
  interesting because you are no longer forced to interrupt the chain to e.g.
  wrap the return value into a keyword list or to do any other sort of
  mapping/transformation.

  ## Examples

      iex> Octopus.map(1234, &[user_id: &1])
      [user_id: 1234]

      iex> Octopus.map([1, 2, 3], &[user_ids: &1])
      [user_ids: [1, 2, 3]]

      iex> Octopus.map(%{id: 1234, name: "John"}, &[user_id: &1.id])
      [user_id: 1234]

  ## Without Octopus

  As you can see in the following example, you need to interrupt the chain to
  wrap `user_id` into a keyword list before you can call `Blog.Posts.all/1`.

      user =
        request
        |> get_header("authorization")
        |> extract_token()
        |> User.by_token()

      Blog.Posts.all(user_id: user.id)

  ## With Octopus

  When using `map/2`, you do not need to interrupt your chain:

      request
      |> get_header("authorization")
      |> extract_token()
      |> User.by_token()
      |> Octopus.map(&[user_id: &1.id])
      |> Blog.Posts.get()
  """
  @spec map(any(), mapper()) :: any()
  def map(value, mapper) when is_function(mapper, 1), do: mapper.(value)
end
