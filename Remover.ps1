
Connect-AzureAD

$csvFilePath = Read-Host "Geben Sie den Pfad der CSV-Datei an"

$appDetails = Import-Csv -Path $csvFilePath -Delimiter ';'
$appDetails
$groupedApps = $appDetails | Group-Object ApplicationID

$appToDelete = @()

foreach ($group in $groupedApps) {
    if ($group.Count -gt 1) {
        # Keep one application from each duplicate group
        $appsToKeep = $group.Group | Select-Object -First 1
        $appsToDelete = $group.Group | Where-Object { $_.ObjectID -ne $appsToKeep.ObjectID }
        $appToDelete += $appsToDelete
    } else {
        # If there's no duplicate, mark for deletion
        $appToDelete += $group.Group
    }
}

foreach ($app in $appToDelete) {
    try {
        Write-Host "Lösche Anwendung: $($app.AppName) mit Application ID: $($app.ApplicationID)"
        Remove-AzureADApplication -ObjectId $app.ObjectID
    } catch {
        Write-Host "Fehler beim Löschen der Anwendung $($app.AppName): $_"
    }
}


Write-Host "Fertig mit dem Entfernen der Anwendungen."