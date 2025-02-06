# Define the folder to search for JSON files
$folderPath = ".\DTM"

$outfolderPath = "."

# Initialize an array to hold the JSON contents
$jsonArray = @()

# Recursively get all JSON files from the folder and its subfolders
Get-ChildItem -Path $folderPath -Filter *.json -Recurse | ForEach-Object {
    $jsonContent = Get-Content -Path $_.FullName -Raw | ConvertFrom-Json
    $jsonArray += $jsonContent
}

# Convert the array to JSON and save it to a file
$jsonArray | ConvertTo-Json -Depth 100 | Set-Content -Path "$outfolderPath\combinedDTM.json"
