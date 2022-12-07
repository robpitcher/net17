# Load table details in memory
$stgAccount = Get-AzStorageAccount -ResourceGroupName storagerg -Name ropistg
$stgCtx = $stgaccount.Context
$stgTable = Get-AzStorageTable -name versions -Context $stgCtx
$cloudTable = $stgTable.CloudTable
$partitionKey1 = "partition1"

# Get the row data
$tableRow = Get-AzTableRow -Table $cloudTable -PartitionKey $partitionKey1 -RowKey ${env:rowKey}

# Get current version info from row data
$versionInfo = $tableRow.version

# Isolate and convert revision from string to int
$currentRevision = ($versionInfo.Split('.')[-1] / 1)

# Increment revision number
$currentRevision ++

# Get project file contents w/ existing revision number
$output1 = get-content -Path ${env:repoPath}\outputs\output1.txt

# Replace existing revision number with updated revision 
$output1 -replace "RevisionVer=\d*","RevisionVer=$currentRevision" | Set-Content -Path ${env:repoPath}\outputs\output1.txt

# Create updated full version number
$newVersion = $versionInfo.Split('.')[0] + "." + $versionInfo.Split('.')[1] + "." + $currentRevision

# Update the table row with the new version number
$tableRow.version = $newVersion
$tableRow | Update-AzTableRow -Table $cloudTable