Try {
    $counter = 0
    $bulk = Import-Csv -Delimiter ";" -Path $ADuserBulkCreateCSV
    $bulkCount = @($bulk).Count
    
    $accountsJson =  $accounts | ConvertFrom-Json
    $accountsJsonCount = @($accountsJson).Count
    
    if($accountsJsonCount -gt 0) {
        if($bulkCount -gt 0) {
            foreach ($a in $accountsJson) {
                $upn = $a.userprincipalname
                
                if([string]::IsNullOrEmpty($upn) -eq $false) {
                    foreach($b in $bulk) {
                        
                        if($upn -eq $b.userprincipalname) {
                            $ADUserParams = @{
                                Path = $b.path
                                Name            =   $b.name
                                DisplayName = $b.displayname
                                Initials = $b.initials
                                GivenName = $b.givenname
                                Surname  = $b.lastname
                                SamAccountName   =   $b.samaccountname
                                UserPrincipalName  = $b.userprincipalname
                                EmailAddress = $b.email
                                Description = $b.description
                                Company = $b.company
                                Department = $b.department
                                Title = $b.title
                                Enabled = ($b.enabled -eq 1)
                                AccountPassword =   (ConvertTo-SecureString -AsPlainText "Welcome01!" -Force)
                            }
                            
                            try {
                                New-ADUser @ADUserParams
                                $counter++
    
                                HID-Write-Status -Message "AD user [$upn] created successfully" -Event Success
                            } catch {
                                HID-Write-Status -Message "Error creating AD user [$upn]. Error: $($_.Exception.Message)" -Event Error
                            }
                        }
                    }
                }
            }

            HID-Write-Status -Message "Finished creating $counter AD accounts" -Event information
            HID-Write-Summary -Message "Finished creating $counter AD accounts" -Event information        
        } else {
           HID-Write-Status -Message "No AD accounts available in CSV" -Event Information 
        }
    } else {
        HID-Write-Status -Message "No AD accounts to be created" -Event Information
    }
} catch {
    HID-Write-Status -Message "Error creating bulk ad accounts. Error: $($_.Exception.Message)" -Event Error
    HID-Write-Summary -Message "Error creating bulk ad accounts" -Event Failed
}
