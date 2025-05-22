# === Configurable Parameters ===
$rootPath = "D:\Shared"                           # <-- Directory to scan
$outputCsv = "C:\Report\FileSystemInventory.csv"  # <-- Output CSV path

# === Recursive scan of all files and folders ===
$results = Get-ChildItem -Path $rootPath -Recurse -Force -ErrorAction SilentlyContinue | ForEach-Object {
    try {
        $item = Get-Item $_.FullName -ErrorAction Stop
        $acl = Get-Acl -Path $item.FullName -ErrorAction Stop

        # Build compact string of NTFS permissions
        $permissions = $acl.Access | ForEach-Object {
            "$($_.IdentityReference): $($_.FileSystemRights)"
        } -join " | "

        # Determine extension or "Folder"
        $extension = if ($item.PSIsContainer) { "Folder" } else { $item.Extension }

        [PSCustomObject]@{
            Path              = $item.FullName
            Type              = if ($item.PSIsContainer) { "Folder" } else { "File" }
            Extension         = $extension
            Size_Bytes        = if (-not $item.PSIsContainer) { $item.Length } else { "" }
            CreatedDate       = $item.CreationTime
            LastAccessedDate  = $item.LastAccessTime
            LastModifiedDate  = $item.LastWriteTime
            Owner             = $acl.Owner
            Permissions       = $permissions
        }
    } catch {
        [PSCustomObject]@{
            Path              = $_.FullName
            Type              = "Error"
            Extension         = "Error"
            Size_Bytes        = "N/A"
            CreatedDate       = "N/A"
            LastAccessedDate  = "N/A"
            LastModifiedDate  = "N/A"
            Owner             = "Error"
            Permissions       = "Error"
        }
    }
}

# === Export to CSV using semicolon delimiter ===
$results | ConvertTo-Csv -Delimiter ';' -NoTypeInformation | Set-Content -Path $outputCsv -Encoding UTF8

Write-Host "✅ Report successfully generated at: $outputCsv"
