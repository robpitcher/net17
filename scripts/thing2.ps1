$output2 = get-content -Path .\outputs\output2.txt

$currentRevision = ($output2 | Select-String "RevisionVer=\d*").ToString().Split('=')[1]

$currentRevision = ($currentRevision / 1)

$currentRevision ++

$newRevision = $currentRevision

$output2 -replace "RevisionVer=\d*","RevisionVer=$newRevision" | Set-Content -Path .\outputs\output2.txt