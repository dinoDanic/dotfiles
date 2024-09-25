## create migration

mix ecto.gen.migration create_images

## create context (also creates migraion)

mix phx.gen.context Items Item items

## pagination

```elixir
# schema.ex:
use Absinthe.Schema.Notation
use Absinthe.Relay.Schema, :modern

connection(node_type: :message)

# ur file

use Absinthe.Relay.Schema.Notation, :modern
connection field :messages, node_type: :message do
    resolve(&ChatMessageResolver.preload_messages/3)
end

# resolver
def preload_messages(parent, args, _) do
    preload = parent |> Rentaj.Repo.preload(:messages) |> Map.get(:messages)
    Connection.from_list(preload, args)
end
```
