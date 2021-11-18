# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rockelivery.Repo.insert!(%Rockelivery.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Rockelivery.{Item, Order, Repo, User}

user = %User{
  age: 27,
  address: "Street seed",
  cep: "01001000",
  cpf: "12345678901",
  email: "johndoe@seed.com",
  password: "2345v6f24q23c",
  name: "John Doe Seed",
  id: "b2869b80-e17d-46dd-adaf-349d1144bba6"
}

%User{id: user_id} = Repo.insert!(user)

item1 = %Item{
  category: :food,
  description: "food seed",
  price: Decimal.new("15.50"),
  photo: "priv/photos/food_seed.png"
}

item2 = %Item{
  category: :food,
  description: "food seed 2",
  price: Decimal.new("10.50"),
  photo: "priv/photos/food_seed_2.png"
}

Repo.insert!(item1)
Repo.insert!(item2)

order = %Order{
  user_id: user_id,
  items: [item1, item1, item2],
  address: "Streed any seed, 37",
  comments: "no sugar",
  payment_method: :money
}

Repo.insert!(order)
