# Load table details in memory
$stgAccount = Get-AzStorageAccount -ResourceGroupName storagerg -Name ropistg
$stgCtx = $stgaccount.Context
$stgTable = Get-AzStorageTable -name versions -Context $stgCtx
$cloudTable = $stgTable.CloudTable

# Get the rows
$partitionKey1 = "partition1"

$tableRow = Get-AzTableRow -Table $cloudTable -PartitionKey $partitionKey1 -RowKey ${env:rowKey}

$output1 = get-content -Path ${env:repoPath}\outputs\output1.txt

$currentRevision = ($output1 | Select-String "RevisionVer=\d*").ToString().Split('=')[1]

$versionInfo = $tableRow.version
$currentRevision = ($versionInfo.Split('.')[-1] / 1)

$currentRevision ++

# Set incremented revision
$output1 -replace "RevisionVer=\d*","RevisionVer=$currentRevision" | Set-Content -Path ${env:repoPath}\outputs\output1.txt

# Create updated version number
$newVersion = $versionInfo.Split('.')[0] + "." + $versionInfo.Split('.')[1] + "." + $currentRevision

$tableRow.version = $newVersion

$tableRow | Update-AzTableRow -Table $cloudTable