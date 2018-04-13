defmodule Current.Admin.Auth do
    alias Current.Repo
    alias CurrentWeb.Guardian
    alias Current.Admin.User
    import Comeonin.Bcrypt, only: [checkpw: 2]

    defp get_by_username(username) do
        case Repo.get_by(User, username: username) do
            nil -> {:error, "nill error"}
            user -> {:ok, user}
        end
    end

    defp verify_password(password, user) do
        if checkpw(password, user.password) do
            {:ok, user}
        else
            {:error, "Invalid password"}
        end
    end

    defp username_password_auth(username, password) do
        with {:ok, user} <- get_by_username(username),
        do: verify_password(password, user)
    end

    def token_signin(username, password) do
        case username_password_auth(username, password) do
            {:ok, user} -> Guardian.encode_and_sign(user)
            _ ->
                {:error, :unauthorized}
        end
    end
end


