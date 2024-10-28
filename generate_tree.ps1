# Script to generate a directory tree with file listing, excluding specific folders
# Usage: Save this script as generate_filtered_tree.ps1 and run it from the project directory

# Define the output file name
$outputFile = "tree_output.txt"

# Define the list of folders to ignore (add any other folders as needed)
$ignoreFolders = @(".env", ".venv", "node_modules", ".netlify", ".vs", "public", "functions-templates", "telemetry", "datetime", "lambda", "@netlify", "netlify", "node-cookies")

# Convert the ignore list to a regular expression pattern
$ignorePattern = "^((?!.*[\\\/](" + ($ignoreFolders -join "|") + ")[\\\/]).)*$"

# Run the tree command with file listing, filter out ignored folders, and output to file
tree /f /a | Select-String -Pattern $ignorePattern | Out-File -FilePath $outputFile

# Confirm completion
Write-Host "Directory tree generated in $outputFile, ignoring specified folders."
