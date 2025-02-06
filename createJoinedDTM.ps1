# Define the folder to search for JSON files
$folderPath = ".\DTM"

$outfolderPath = "."

# Initialize an array to hold the JSON contents
$jsonArray = @()

$first = $true

# Recursively get all JSON files from the folder and its subfolders
Get-ChildItem -Path $folderPath -Filter *.json -Recurse | ForEach-Object {
    try {
            $jsonContent = Get-Content -Path $_.FullName -Raw 

            if ($first) {
                $jsonArray += $jsonContent
                $first = $false
            }
            else {
                $jsonArray += " , " + $jsonContent
            }
      }
    catch {
        $errorMessage = $_.Exception.Message
        Write-Host "Failed to convert file to JSON: $($_.FullName)"
        Write-Host "Error: $errorMessage"
        # Optionally, log the error to a file
        Add-Content -Path .\error_log.txt -Value "Failed to convert file to JSON: $($_.FullName)`nError: $errorMessage`n"
        throw "Exiting due to error in file: $($_.FullName)"
    }
}

# Convert the array to JSON and save it to a file
"[" + $jsonArray + "]"  | Set-Content -Path "$outfolderPath\combinedDTM.json"
