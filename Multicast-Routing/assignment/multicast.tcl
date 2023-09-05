# Create a new NS2 simulator instance with multicast support
set ns [new Simulator -multicast on]

# Turn on Tracing
set tf [open Multicast-Output.tr w]
$ns trace-all $tf

# Turn on nam Tracing
set fd [open mcast.nam w]
$ns namtrace-all $fd

# Create nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]
set n9 [$ns node]
set n10 [$ns node]
set n11 [$ns node]
set n12 [$ns node]
set n13 [$ns node]
set n14 [$ns node]

# Create links with DropTail Queues
$ns duplex-link $n0 $n2 1.5Mb 10ms DropTail
$ns duplex-link $n1 $n2 1.5Mb 10ms DropTail
$ns duplex-link $n2 $n3 1.5Mb 10ms DropTail
$ns duplex-link $n3 $n4 1.5Mb 10ms DropTail
$ns duplex-link $n3 $n7 1.5Mb 10ms DropTail
$ns duplex-link $n4 $n5 1.5Mb 10ms DropTail
$ns duplex-link $n4 $n6 1.5Mb 10ms DropTail
$ns duplex-link $n7 $n8 1.5Mb 10ms DropTail
$ns duplex-link $n7 $n9 1.5Mb 10ms DropTail
$ns duplex-link $n7 $n10 1.5Mb 10ms DropTail
$ns duplex-link $n7 $n11 1.5Mb 10ms DropTail
$ns duplex-link $n7 $n12 1.5Mb 10ms DropTail
$ns duplex-link $n7 $n13 1.5Mb 10ms DropTail
$ns duplex-link $n7 $n14 1.5Mb 10ms DropTail

# Set the multicast routing protocol to Dense Mode
set mproto DM
set mrthandle [$ns mrtproto $mproto {}]

# Set three group addresses
set group1 [Node allocaddr]
set group2 [Node allocaddr]
set group3 [Node allocaddr]

# UDP Transport agent for the traffic source for group1
set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0
$udp0 set dst_addr_ $group1
$udp0 set dst_port_ 0
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp0

# UDP Transport agent for the traffic source for group2
set udp1 [new Agent/UDP]
$ns attach-agent $n1 $udp1
$udp1 set dst_addr_ $group2
$udp1 set dst_port_ 0
set cbr2 [new Application/Traffic/CBR]
$cbr2 attach-agent $udp1

# UDP Transport agent for the traffic source for group3
set udp2 [new Agent/UDP]
$ns attach-agent $n8 $udp2
$udp2 set dst_addr_ $group3
$udp2 set dst_port_ 0
set cbr3 [new Application/Traffic/CBR]
$cbr3 attach-agent $udp2

# Create receiver to accept the packets for group1
set rcvr1 [new Agent/Null]
$ns attach-agent $n5 $rcvr1
$ns at 1.0 "$n5 join-group $rcvr1 $group1"

# Create receiver to accept the packets for group2
set rcvr2 [new Agent/Null]
$ns attach-agent $n6 $rcvr2
$ns at 1.5 "$n6 join-group $rcvr2 $group2"

# Create receiver to accept the packets for group3
set rcvr3 [new Agent/Null]
$ns attach-agent $n9 $rcvr3
$ns at 1.0 "$n9 join-group $rcvr3 $group3"

# The nodes are leaving the groups at specified times
$ns at 3.0 "$n5 leave-group $rcvr1 $group1"
$ns at 3.5 "$n6 leave-group $rcvr2 $group2"
$ns at 4.0 "$n9 leave-group $rcvr3 $group3"

# Schedule events

$ns at 0.5 "$cbr1 start"
$ns at 9.5 "$cbr1 stop"
$ns at 0.5 "$cbr2 start"
$ns at 9.5 "$cbr2 stop"
$ns at 0.5 "$cbr3 start"
$ns at 9.5 "$cbr3 stop"

# Post-processing

$ns at 10.0 "finish"
proc finish {} {
    global ns tf
    $ns flush-trace
    close $tf
    exec nam mcast.nam &
    exit 0
}

$ns set-animation-rate 3.0ms
$ns run

