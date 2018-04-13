defmodule Current.Admin.AuthPipeline do
    use Guardian.Plug.Pipeline, otp_app: :Current,
    module: CurrentWeb.Guardian,
    error_handler: CurrentWeb.ErrorHandler

    plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
    plug Guardian.Plug.LoadResource, allow_blank: true
    plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  
end