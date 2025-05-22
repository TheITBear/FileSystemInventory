# Windows File System Inventory Script

This repository provides a PowerShell script that recursively scans a Windows file server and generates a detailed CSV report. It includes metadata such as:

- Full path of files and folders
- File type (File/Folder)
- File extension
- Size (bytes)
- Creation date
- Last access date
- Last modified date
- NTFS Owner
- NTFS Permissions

The CSV uses a semicolon (`;`) delimiter for compatibility with regional settings (e.g., Excel in Europe).

## 🔧 Requirements

- Windows PowerShell 5.1 or PowerShell 7+
- Execution with administrative privileges (to read all ACLs)

## 🚀 Usage

1. Clone the repository or download the script `FileSystemInventory.ps1`
2. Open PowerShell as Administrator
3. Modify the two main variables at the top of the script:

```powershell
$rootPath = "D:\Shared"                      # Path to scan
$outputCsv = "C:\Report\Inventory.csv"      # Output CSV file
```

4. Run the script:
```powershell
.\FileSystemInventory.ps1
```

## 📁 Output Example

| Path                | Type   | Extension | Size_Bytes | Owner         | Permissions               |
|---------------------|--------|-----------|------------|----------------|---------------------------|
| D:\Shared\Notes.txt | File   | .txt      | 1240       | DOMAIN\user1   | DOMAIN\user1: FullControl |
| D:\Shared\Projects  | Folder | Folder    |            | DOMAIN\admin   | DOMAIN\admin: Modify      |

## 📄 License

This project is licensed under the MIT License.

## 🙋 Support

For issues or enhancements, please open an [issue](https://github.com/your-org/windows-filesystem-inventory/issues) or submit a pull request.
