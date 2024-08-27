IO.puts("What do you want do?: ")
user_input = IO.gets("> ")

# Get the OS type and version
os_type = :os.type()
os_version = :os.version()

# Convert the OS version tuple to a string
os_version_string = 
  :os.version()
  |> Tuple.to_list()
  |> Enum.join(".")

IO.puts(os_version_string)

# Get OpenAI key
api_key = System.get_env("OPENAI_API_KEY")

config_override = %OpenAI.Config{api_key: api_key}

# Assuming `response_tuple` is what you get from OpenAI.chat_completion
# Assuming `response_tuple` is what you get from OpenAI.chat_completion
response_tuple = OpenAI.chat_completion([
  model: "gpt-4o-mini",
  messages: [
    %{role: "system", content: "Your job is to help the user to use CLI, ONLY RETURN CODE NO EXPLANATION NO MARKDOWN"},
    %{role: "assistant", content: "User OS Version: #{os_version_string}"},
    %{role: "user", content: "#{user_input}"}
  ]
], config_override)

case response_tuple do
  {:ok, response} ->
    content = response
              |> Map.get(:choices)
              |> List.first()
              |> Map.get("message")
              |> Map.get("content")

    if content do
    
      # Attempt to run the command and capture any errors
      IO.puts(content)
      try do
        [command | args] = String.split(content, " ")

        {output, exit_status} = System.cmd(command, args)

        IO.puts("Output:")
        IO.puts(output)
        IO.puts("Exit status: #{exit_status}")
      rescue
        # Handle the case where the command is not found or fails
        e in ErlangError -> 
          IO.puts("Failed to execute command: #{inspect(e)}")
      end
    else
      IO.puts("No content returned from OpenAI API.")
    end

  {:error, reason} ->
    IO.puts("Failed to get a response from OpenAI API: #{inspect(reason)}")
end


