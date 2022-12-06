Connect-AzAccount -Identity

# Load table details in memory
$stgAccount = Get-AzStorageAccount -ResourceGroupName storagerg -Name ropistg
$stgCtx = $stgaccount.Context
$stgTable = Get-AzStorageTable -name versions -Context $stgCtx
$cloudTable = $stgTable.CloudTable

# Create the rows
$partitionKey1 = "partition1"

$tableRow = Get-AzTableRow -Table $cloudTable -PartitionKey $partitionKey1 -RowKey ${env:rowKey}

$output1 = get-content -Path .\outputs\output1.txt

$currentRevision = ($output1 | Select-String "RevisionVer=\d*").ToString().Split('=')[1]

$currentRevision = ($tableRow.version.Split('.')[-1] / 1)

$currentRevision ++

$newRevision = $currentRevision

Write-Host "currently in $pwd"

$output1 -replace "RevisionVer=\d*","RevisionVer=$newRevision" | Set-Content -Path ${env:repoPath}\outputs\output1.txt
