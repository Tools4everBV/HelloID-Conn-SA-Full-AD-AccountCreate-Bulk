Try {
    $counter = 0
    $bulk = Import-Csv -Delimiter ";" -Path $ADuserBulkCreateCSV
    $bulkCount = @($bulk).Count
    
    $accounts = $form.createBulk.leftToRight
    $accountsCount = @($accounts).Count

    if($accountsCount -gt 0) {
        if($bulkCount -gt 0) {
            foreach ($a in $accounts) {
                $upn = $a.userprincipalname
                if([string]::IsNullOrEmpty($upn) -eq $false) {
                    foreach($b in $bulk) {
                        if($upn -eq $b.userprincipalname) {
                            $ADUserParams = @{
                                Path                = $b.path
                                Name                = $b.name
                                DisplayName         = $b.displayname
                                Initials            = $b.initials
                                GivenName           = $b.givenname
                                Surname             = $b.lastname
                                SamAccountName      = $b.samaccountname
                                UserPrincipalName   = $b.userprincipalname
                                EmailAddress        = $b.email
                                Description         = $b.description
                                Company             = $b.company
                                Department          = $b.department
                                Title               = $b.title
                                Enabled             = ($b.enabled -eq 1)
                                AccountPassword     = (ConvertTo-SecureString -AsPlainText "Welcome01!" -Force)
                            }
                            
                            try {
                                New-ADUser @ADUserParams
                                $counter++
                                Write-Information -Message "AD user [$upn] created successfully"

                                $adUser = Get-ADuser -Filter { UserPrincipalName -eq $upn } | Select-Object SID
                                $adUserSID = $([string]$adUser.SID)
                                $Log = @{
                                    Action            = "CreateAccount" # optional. ENUM (undefined = default) 
                                    System            = "ActiveDirectory" # optional (free format text) 
                                    Message           = "Created account with username $upn" # required (free format text) 
                                    IsError           = $false # optional. Elastic reporting purposes only. (default = $false. $true = Executed action returned an error) 
                                    TargetDisplayName = $($b.displayName) # optional (free format text) 
                                    TargetIdentifier  = $adUserSID # optional (free format text) 
                                }
                                #send result back  
                                Write-Information -Tags "Audit" -MessageData $log
                            } catch {
                                Write-Error -Message "Error creating AD user [$upn]. Error: $($_.Exception.Message)" 
                            }
                        }
                    }
                }
            }
            Write-Information -Message "Finished creating $counter AD accounts"        
        } else {
            Write-Warning -Message "No AD accounts available in CSV" 
        }
    } else {
        Write-Information -Message "No AD accounts to be created" 
    }
} catch {
    Write-Error -Message "Error creating bulk ad accounts. Error: $($_.Exception.Message)" 
}
