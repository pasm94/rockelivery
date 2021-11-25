defmodule Rockelivery.Users.CreateTest do
  use Rockelivery.DataCase, async: true

  doctest Rockelivery.Users.Create

  import Mox
  import Rockelivery.Factory

  alias Rockelivery.Users.Create
  alias Rockelivery.{Error, User}
  alias Rockelivery.ViaCep.ClientMock

  describe "call/1" do
    test "when all params are valid, returns the user" do
      params = build(:user_params)

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok, build(:cep_info)}
      end)

      response = Create.call(params)

      assert {:ok, %User{email: "johndoe@test.com", name: "John Doe"}} = response
    end

    test "when there are invalid params, returns an error" do
      params = build(:user_params, %{"age" => 15})

      response = Create.call(params)

      expected_response = %{age: ["must be greater than or equal to 18"]}

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
