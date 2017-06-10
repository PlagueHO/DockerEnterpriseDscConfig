
<#PSScriptInfo

.VERSION 1.0.0.2

.GUID e4b6f09d-71ad-46ee-b219-e1895fa7dbd7

.AUTHOR Daniel Scott-Raynsford

.COMPANYNAME 

.COPYRIGHT 

.TAGS DSC Config

.LICENSEURI https://github.com/PlagueHO/DockerEnterpriseDscConfig/blob/master/LICENSE

.PROJECTURI http://github.com/PlagueHO/DockerEnterpriseDscConfig

.ICONURI 

.EXTERNALMODULEDEPENDENCIES

.REQUIREDSCRIPTS 

.EXTERNALSCRIPTDEPENDENCIES 

.RELEASENOTES

#Requires -Module DockerEnterpriseDscConfigModule
#Requires -Module PackageManagementProviderResource
<#
    .DESCRIPTION 
    Example configuration script to demonstrate pairing a PowerShell Desired State Configuration script with a module that contains supporting assets. 

    .EXAMPLE
    DockerEnterpriseDscConfig -configdata c:\dsc\DockerEnterpriseDscConfig\ConfigurationData\DockerEnterpriseDscConfig.ConfigData.psd1 -outpath c:\dsc\DockerEnterpriseDscConfig\MOF
#> 
configuration DockerEnterpriseDscConfig
{
    Import-DscResource -ModuleName 'PackageManagementProviderResource'
    
    Node $AllNodes.NodeName
    {
        PSModule DockerMsftProvider
        {
            Ensure             = 'Present'
            Name               = 'DockerMsftProvider'
            InstallationPolicy = 'Trusted'
            Repository         = 'PSGallery'
        }

        PackageManagement DockerPackage
        {
            Ensure       = 'Present'
            Name         = 'docker'
            ProviderName = 'DockerMsftProvider'
            DependsOn    = '[PSModule]DockerMsftProvider'
        }
    }
}
