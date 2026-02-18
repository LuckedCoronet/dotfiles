Set-PSReadLineOption -PredictionSource None

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)

    $prompt = ""
    function Invoke-Starship-PreCommand {
        $current_location = $executionContext.SessionState.Path.CurrentLocation
        if ($current_location.Provider.Name -eq "FileSystem") {
            $ansi_escape = [char]27
            $provider_path = $current_location.ProviderPath -replace "\\", "/"
            $prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
        }
        $host.ui.Write($prompt)
    }

    function Invoke-Starship-TransientFunction {
        &starship module character
    }

    Enable-TransientPrompt
}
