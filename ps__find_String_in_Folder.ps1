
## find String in Folder ...


## input
$folder = 'C:\Projects\ATAS_original_from_github\Indicators-Develop\Technical'
$filter = "*.cs"
$string = "UseAlert"
$outfile = "C:\temp\_result.txt"


## ----------
$result = "string: '" + $string + "' in folder: " + $folder + [Environment]::NewLine
$result = $result     + "------"                            + [Environment]::NewLine
$result = $result     + " "

$folderArray = @()
Get-ChildItem $folder -Filter $filter -Recurse |
ForEach-Object {
      If (Get-Content $_.FullName | Select-String -Pattern $string ){
          $folderArray = $folderArray + $_.FullName + [Environment]::NewLine
      }
}

##-----------
$result = $result + $folderArray | Sort-object | Get-Unique   ##----
$result | Out-File $outfile

## ----  end  ----
