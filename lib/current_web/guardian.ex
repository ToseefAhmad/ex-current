defmodule CurrentWeb.Guardian do
    use Guardian, otp_app: :current

    def subject_for_token(user, _claims) do
        sub = to_string(user.id)
        {:ok, sub}
    end

    def resource_from_claims(claims) do
        id = claims["sub"]
        {:ok, Current.Admin.get_user!(id)}
    end

    def resource_from_claims(_claims) do
        {:error, :reason}
      end
    

end