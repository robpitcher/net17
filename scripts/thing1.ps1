# $output1 = get-content -Path .\outputs\output1.txt

# $currentRevision = ($output1 | Select-String "RevisionVer=\d*").ToString().Split('=')[1]

# $currentRevision = ($currentRevision / 1)

# $currentRevision ++

# $newRevision = $currentRevision

# $output1 -replace "RevisionVer=\d*","RevisionVer=$newRevision" | Set-Content -Path .\outputs\output1.txt


# Added a feature
# testing history 1 change
# testing history 2 change
# testing history 3 change
# testing history 4 change
# test 5
# Testing a dev branch???
# now i should be testing dev branch