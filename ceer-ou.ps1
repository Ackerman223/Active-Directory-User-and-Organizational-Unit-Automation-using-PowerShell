# Donner le path vers votre fichier CSV
$ADUsers = Import-Csv '.\new-ou.csv'
$monDomaine = "DC=skynet,DC=local"
$OUBasePath = "OU=Skynet Users,$monDomaine"

# Créer l'OU "Skynet Users" si elle n'existe pas encore
if (-not (Get-ADOrganizationalUnit -Filter {Name -eq 'Skynet Users'} -SearchBase $monDomaine)) {
    New-ADOrganizationalUnit -Name "Skynet Users" -Path $monDomaine
}

foreach ($User in $ADUsers) {
    $Departement = $User.departement
    $Bureau = $User.bureau

    # Créer l'OU pour le département s'il n'existe pas encore
    $OUDepartementPath = "OU=$Departement,$OUBasePath"
    if (-not (Get-ADOrganizationalUnit -Filter {Name -eq $Departement} -SearchBase $OUBasePath)) {
        New-ADOrganizationalUnit -Name $Departement -Path $OUBasePath
    }

    # Créer l'OU pour le bureau s'il n'existe pas encore
    $OUBureauPath = "OU=$Bureau,$OUDepartementPath"
    if (-not (Get-ADOrganizationalUnit -Filter {Name -eq $Bureau} -SearchBase $OUDepartementPath)) {
        New-ADOrganizationalUnit -Name $Bureau -Path $OUDepartementPath
    }
}
