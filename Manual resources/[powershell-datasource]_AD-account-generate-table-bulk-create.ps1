Try {
    $exists = Test-Path -Path $ADuserBulkCreateCSV
    if ($exists) {
        $bulk = Import-Csv -Delimiter ";" -Path $ADuserBulkCreateCSV
        $userCount = @($bulk).Count
        
        Write-Information "Result count: $userCount"
        
        if($userCount -gt 0) {
            foreach($b in $bulk) {
                $tmp = $b.displayName + " (" + $b.UserPrincipalName + ") [" + $b.Department + " >> " + $b.Title + "]"
                $returnObject = @{displayValue = $tmp; UserPrincipalName = $b.UserPrincipalName}
                Write-Output $returnObject
            }
        } else {
            return
        }
    } else {
        Write-error "File does not exist! Error: $($_ | ConvertTo-Json)"
    }
} catch {
    Write-error "Error getting bulk create AD users. Error: $($_.Exception.Message)"
}
