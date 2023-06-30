function Connect-PMGService{
param(
[CmdletBinding()]
[Parameter(Mandatory=$true)]
        [System.Guid] $TenantID,
[Parameter(Mandatory=$true)]
        [System.Guid] $ClientID,
[Parameter(Mandatory=$true)]
        [String] $ClientSecret
)

try{
    $body = @{
    client_id     = $ClientID
    scope         = "https://graph.microsoft.com/.default"
    client_secret = $ClientSecret
    grant_type    = "client_credentials"   
}

$tokenRequest = Invoke-WebRequest -Method Post -Uri "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token" -ContentType "application/x-www-form-urlencoded" -Body $body -UseBasicParsing -ErrorAction Stop
    $Script:token = ($tokenRequest.Content | ConvertFrom-Json).access_token
    if($null -eq $true){
        Write-Host "Unable to retrieve token" -ForegroundColor Red
    }
    else{
        Write-Host "Token successfully generated" -ForegroundColor Green
    }
}
catch{
    throw "Error: Token generation failure. $_"
}


}


function New-PMGUser{
param(
[CmdletBinding()]
[Parameter(Mandatory=$true)]
        [String] $UserPrincipalName,
[Parameter(Mandatory=$true)]
        [String] $DisplayName,
[Parameter(Mandatory=$true)]
        [String] $MailNickname,
[Parameter(Mandatory=$false)]
        [Boolean] $AccountEnabled = $true,
[Parameter(Mandatory=$false)]
        [Boolean] $ForceChangePasswordNextSignIn = $false,
[Parameter(Mandatory=$false)]
        [Boolean] $ForceChangePasswordNextSignInWithMfa = $false
)

$user = @{
"userPrincipalName"= "$UserPrincipalName"
"displayName"= "$DisplayName"
"mailNickname"=$MailNickname
"accountEnabled"=$AccountEnabled
"passwordProfile"= @{
    "forceChangePasswordNextSignIn" = $false
    "forceChangePasswordNextSignInWithMfa" = $false
    "password"="P@ssw0rd123!"
}
  } | ConvertTo-Json

$URL="https://graph.microsoft.com/v1.0/users"

$authHeader1 = @{
   'Authorization'="Bearer $Script:token"
}

try{
 $requestData = Invoke-WebRequest -Headers $AuthHeader1 -Uri $URL -Body $user -Method Post -ContentType "application/json"
 if($requestData.StatusDescription -eq "Created"){
    $userDetails = $requestData.Content | ConvertFrom-Json  
 }
 else{
    Write-Host "User could not be created"
 }
 return $userDetails
}
catch{
    throw "Error cannot complete request. $_"
}

}