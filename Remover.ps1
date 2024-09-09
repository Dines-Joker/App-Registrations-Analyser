# Connect to Azure AD
Connect-AzureAD

# Prompt the user to input the CSV file path
$csvFilePath = Read-Host "Geben Sie den Pfad der CSV-Datei an"

# Import CSV file
$appDetails = Import-Csv -Path $csvFilePath -Delimiter ','
$appDetails

# Group apps by ApplicationID
$groupedApps = $appDetails | Group-Object ApplicationID

# Prepare list of apps to delete
$appToDelete = @()

# Iterate over grouped apps
foreach ($group in $groupedApps) {
    if ($group.Count -gt 1) {
        # Keep one instance of the app and mark others for deletion
        $appsToKeep = $group.Group | Select-Object -First 1
        $appsToDelete = $group.Group | Where-Object { $_.ObjectID -ne $appsToKeep.ObjectID }
        $appToDelete += $appsToDelete
    } else {
        $appToDelete += $group.Group
    }
}

# Remove applications from Azure AD
foreach ($app in $appToDelete) {
    try {
        Write-Host "Lösche Anwendung: $($app.AppName) mit Application ID: $($app.ApplicationID)"
        Remove-AzureADApplication -ObjectId $app.ObjectID
    } catch {
        Write-Host "Fehler beim Löschen der Anwendung $($app.AppName): $_"
    }
}

Write-Host "Fertig mit dem Entfernen der Anwendungen."
