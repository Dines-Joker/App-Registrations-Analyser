Connect-AzureAD

$appRegistrations = Get-AzureADApplication

$outputFilePath = Read-Host "Geben Sie den Pfad für die Ausgabedatei an"

$appDetailsList = @()

foreach ($app in $appRegistrations) {
    # Get certificates and secrets
    $certificates = Get-AzureADApplicationKeyCredential -ObjectId $app.ObjectId
    $secrets = Get-AzureADApplicationPasswordCredential -ObjectId $app.ObjectId
    
    if (-not $certificates -and -not $secrets) {
        $appDetailsList += [PSCustomObject]@{
            AppName           = $app.DisplayName
            ApplicationID     = $app.AppId
            ObjectID          = $app.ObjectId
            ReplyURLs         = $app.ReplyUrls -join ', '
            CredentialType    = 'None'
            KeyID             = 'N/A'
            EndDate           = 'N/A'
            CreatedOn         = if ($app.CreatedDateTime) { $app.CreatedDateTime.ToString('yyyy-MM-dd') } else { 'N/A' }
            Owners            = $owners
            RequiredResources = $requiredResourceAccess
        }
    }

    foreach ($cert in $certificates) {
        $appDetailsList += [PSCustomObject]@{
            AppName           = $app.DisplayName
            ApplicationID     = $app.AppId
            ObjectID          = $app.ObjectId
            ReplyURLs         = $app.ReplyUrls -join ', '
            CredentialType    = 'Certificate'
            KeyID             = $cert.KeyId
            EndDate           = $cert.EndDate.ToString('yyyy-MM-dd')
            CreatedOn         = if ($app.CreatedDateTime) { $app.CreatedDateTime.ToString('yyyy-MM-dd') } else { 'N/A' }
            Owners            = $owners
            RequiredResources = $requiredResourceAccess
        }
    }

    foreach ($secret in $secrets) {
        $appDetailsList += [PSCustomObject]@{
            AppName           = $app.DisplayName
            ApplicationID     = $app.AppId
            ObjectID          = $app.ObjectId
            ReplyURLs         = $app.ReplyUrls -join ', '
            CredentialType    = 'Client Secret'
            KeyID             = $secret.KeyId
            EndDate           = $secret.EndDate.ToString('yyyy-MM-dd')
            CreatedOn         = if ($app.CreatedDateTime) { $app.CreatedDateTime.ToString('yyyy-MM-dd') } else { 'N/A' }
            Owners            = $owners
            RequiredResources = $requiredResourceAccess
        }
    }
}


$appDetailsList | Export-Csv -Path $outputFilePath -NoTypeInformation -Encoding UTF8

Write-Host "Exportiert nach $outputFilePath"
