# Active Directory User and Organizational Unit Automation using PowerShell

## Overview
This PowerShell-based project is designed to streamline the management and creation of users and Organizational Units (OUs) within Microsoft Active Directory (AD). It automates the process of creating users, organizing them into appropriate OUs based on departments, and setting up their credentials and other user account properties. The solution is ideal for system administrators looking to automate repetitive tasks, ensuring consistency, reducing human error, and improving overall efficiency in a Windows Server environment.

## Features

### 1. Automated Organizational Unit Creation
- Automatically creates OUs for each department and location specified in the input CSV file.
- Ensures the required OUs are structured based on a predefined hierarchy (e.g., department, office location).

### 2. Bulk User Account Creation
- Imports user data from a CSV file and creates user accounts in Active Directory.
- Configures user attributes such as name, department, title, office location, and logon credentials.
- Automatically assigns a default password to each user and enforces password change at the first login.

### 3. Error Handling & Logging
- Built-in error handling ensures graceful failure and detailed logging for each user and OU creation process.
- Debug outputs track the progress of user and OU creation in real-time.

## How it Works

### 1. Organizational Unit Creation (`ceer-ou.ps1`)
- Reads from a CSV file (`new-ou.csv`) to identify departments and office locations.
- Checks for the existence of OUs and creates any missing ones in a hierarchical structure (Department > Office Location).

### 2. User Creation (`creation-User.ps1`)
- Reads a CSV file (`users-skynet.csv`) containing user data such as first name, last name, title, department, office location, and logon ID.
- For each user, the script:
  - Constructs a distinguished name (DN) based on the OU structure.
  - Creates the AD user account with attributes such as `SamAccountName`, `UserPrincipalName`, and department.
  - Configures the account to enforce password change at the first login.

### 3. CSV File Format
- The CSV files (`new-ou.csv` and `users-skynet.csv`) should follow a specific format, where columns correspond to AD attributes like department, office location, first name, last name, logon ID, etc.

## Usage

### 1. Prepare the CSV Files:
- Modify `new-ou.csv` to define the departments and locations for your organizational units.
- Populate `users-skynet.csv` with user details, including department, office location, and logon information.

### 2. Run the Scripts:
- Execute `ceer-ou.ps1` to create the necessary OUs in Active Directory.
- Once OUs are in place, run `creation-User.ps1` to create the users in their respective OUs.

## Example Input

### Organizational Units (`new-ou.csv`)
```csv
departement
Management
Marketing
IT
HR
Service
Sales
Operations
```

### User Data (`users-skynet.csv`)
```csv
prenom,nom,titre,departement,bureau,logon
Rebbecca,Didio,Consultant,Management,Toronto,con-tor-7621
Stevie,Hallo,Consultant,Management,Toronto,con-tor-7622
Mariko,Stayer,Consultant,Management,Toronto,con-tor-7623
```

## Requirements
- Windows Server with Active Directory Domain Services (AD DS) installed.
- PowerShell 5.0 or higher.
- Active Directory PowerShell Module (RSAT-AD-PowerShell).

## Conclusion
This project simplifies the administration of Active Directory by automating routine tasks like user creation and organizational unit setup. By leveraging PowerShell, it helps reduce the time required for manual data entry, minimizes errors, and ensures consistency. The script can be customized for various organizational needs and easily adapted to different environments.
