# Load table details in memory
$stgAccount = Get-AzStorageAccount -ResourceGroupName storagerg -Name ropistg
$stgCtx = $stgaccount.Context
$stgTable = Get-AzStorageTable -name versions -Context $stgCtx
$cloudTable = $stgTable.CloudTable

# Create the rows
$partitionKey1 = "partition1"

Add-AzTableRow `
    -table $cloudTable `
    -partitionKey $partitionKey1 `
    -rowKey ("thing1") -property @{"version"="1.0.16";}

Add-AzTableRow `
    -table $cloudTable `
    -partitionKey $partitionKey1 `
    -rowKey ("thing2") -property @{"version"="1.0.3";}