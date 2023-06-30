# Description
This module can be used to leverage Microsoft Graph APIs for Azure Active Directory User Management.

# Prerequisite
In order to connect to Azure AD through this module below are the requirements:
1. Tenent ID
2. Client ID of Azure AD Application
3. Key of Azure AD Application

# Permissions for Azure AD Application
User.Read.All

User.ReadWrite.All

Reference: https://learn.microsoft.com/en-us/graph/permissions-reference

# Cmdlets Description
    1. Connect-PMGService
       Connect-PMGService  -TenantID '00000000-0000-0000-0000-000000000000' -ClientID '00000000-0000-0000-0000-000000000000' -ClientSecret 'ClientKey'
       
<img width="695" alt="image" src="https://github.com/KomalBachchani/MG/assets/44342964/44d877ec-a063-4807-aae4-e23ec5281b2f">

    2.  New-PMGUser - Creates new user in Azure Active Directory
        New-PMGUser -UserPrincipalName "TestUser@Domain.com" -DisplayName "TestUser" -MailNickname "TestUser"

<img width="669" alt="image" src="https://github.com/KomalBachchani/MG/assets/44342964/0419f281-8c77-41c4-a342-f1bf98ae56eb">


