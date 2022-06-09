<#

Purpose of this script is to split large files into smaller, more manageable chunks.
By: Alan Newingham
Date: 6/7/2022

#>


#Location of the large file
$from = "C:\temp\large_CSV.csv"
#New filename, and location root
$rootName = "C:\temp\large_CSV_newchunk"
#New filename extention
$ext = "csv"
#Size you want to break the file into smaller chunks
$fileSize = 100MB

#Do the work.
$fromFile = [io.file]::OpenRead($from)
$buff = new-object byte[] $fileSize
$count = $idx = 0
try {
    do {
        "Reading $fileSize"
        $count = $fromFile.Read($buff, 0, $buff.Length)
        if ($count -gt 0) {
            $to = "{0}.{1}.{2}" -f ($rootName, $idx, $ext)
            $toFile = [io.file]::OpenWrite($to)
            try {
                "Writing $count to $to"
                $tofile.Write($buff, 0, $count)
            } finally {
                $tofile.Close()
            }
        }
        $idx ++
    } while ($count -gt 0)
}
finally {
    $fromFile.Close()
}
