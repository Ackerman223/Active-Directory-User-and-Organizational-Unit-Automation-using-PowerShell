# Spécifiez le chemin du fichier CSV
$csvPath = "C:\Scrip-lab\users-skynet.csv"

# Spécifiez le chemin de l'unité organisationnelle (OU) appropriée dans votre AD
$OU = "OU=Skynet Users,DC=skynet,DC=local"
#$monDomaine = "DC=skynet,DC=local"
#$OUBasePath = "OU=Skynet Users,$monDomaine"

# Lire les utilisateurs depuis le fichier CSV
$users = Import-Csv $csvPath

foreach ($user in $users) {
    $GivenName = $user.Prenom
    $Surname = $user.Nom
    $Title = $user.Titre
    $Department = $user.Departement
    $City = $user.Bureau
    $Logon = $user.Logon

    $SamAccountName = $Logon
    $UserPrincipalName = "$SamAccountName@skynet.local"
    $Password = "Toronto#123"  # Vous pouvez générer un mot de passe aléatoire si nécessaire

    # Construire le nom distinctif (DN)
    $DistinguishedName = "CN=$GivenName $Surname,$OU"

    # Ajouter une sortie de débogage pour afficher les valeurs
    Write-Host "Création de l'utilisateur : $GivenName $Surname"
    Write-Host "Nom distinctif : $DistinguishedName"

    # Essayez de créer l'utilisateur avec gestion des erreurs
    try {
        New-ADUser `
            -SamAccountName $SamAccountName `
            -UserPrincipalName "$UserPrincipalName" `
            -GivenName $GivenName `
            -Surname $Surname `
            -Title $Title `
            -Department $Department `
            -City $City `
            -Name "$GivenName $Surname" `
            -DisplayName "$Surname, $GivenName" `
            -Enabled $true `
            -ChangePasswordAtLogon $true `
            -PasswordNeverExpires $false `
            -Path $OU `
            -AccountPassword (ConvertTo-SecureString -AsPlainText $Password -Force) `
            -PassThru
    }
    catch {
        Write-Host "Erreur lors de la création de l'utilisateur : $_"
    }
}
