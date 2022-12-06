# Load table details in memory
$stgAccount = Get-AzStorageAccount -ResourceGroupName storagerg -Name ropistg
$stgCtx = $stgaccount.Context
$stgTable = Get-AzStorageTable -name versions -Context $stgCtx
$cloudTable = $stgTable.CloudTable

# Create the rows
$partitionKey1 = "partition1"

Get-AzTableRow -Table $cloudTable -PartitionKey $partitionKey1 -RowKey ${env:rowKey}