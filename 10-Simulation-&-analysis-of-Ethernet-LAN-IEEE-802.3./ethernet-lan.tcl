set ns [new Simulator]

# Open the NAM trace file
set nf [open prog.nam w]
$ns namtrace-all $nf

# Open the trace file
set nd [open prog.tr w]
$ns trace-all $nd

# Define a finish procedure
proc finish {} {
    global ns nf nd
    
    $ns flush-trace
    $ns halt
    close $nf
    close $nd
    exec nam prog.nam &
    exit 0
}

# Create 7 nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]

# Create a link between the nodes
$ns duplex-link $n0 $n1 0.2Mb 40ms DropTail
$ns duplex-link $n1 $n2 0.2Mb 40ms DropTail
$ns duplex-link $n2 $n3 0.2Mb 40ms DropTail
$ns duplex-link $n3 $n4 0.2Mb 40ms DropTail
$ns duplex-link $n4 $n5 0.2Mb 40ms DropTail
$ns duplex-link $n5 $n6 0.2Mb 40ms DropTail

# Setup a TCP connection
set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n5 $sink
$ns connect $tcp $sink

# Setup an FTP application over the TCP connection
set ftp [new Application/FTP]
$ftp attach-agent $tcp

# Schedule FTP start and stop events
$ns at 1.0 "$ftp start"
$ns at 5.0 "$ftp stop"
$ns at 5.5 "finish"

# Run the simulation
$ns run

