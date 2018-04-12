defmodule Current.Folder.Task do
    alias Current.Repo
    alias Current.Folder.Test

    def get_by_title(title) do
        Test
        |> Repo.get_by!(title: title)
        
    end
    
end