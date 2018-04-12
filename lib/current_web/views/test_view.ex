defmodule CurrentWeb.TestView do
  use CurrentWeb, :view
  alias CurrentWeb.TestView

  def render("index.json", %{methods: methods}) do
    %{data: render_many(methods, TestView, "test.json")}
  end

  def render("show.json", %{test: test}) do
    %{data: render_one(test, TestView, "test.json")}
  end

  def render("test.json", %{test: test}) do
    %{id: test.id,
      title: test.title,
      description: test.description}
  end
end
