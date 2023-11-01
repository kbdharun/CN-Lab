#creating a simulator object
set ns [ new Simulator ]
$ns color 3 Green
#creating trace file
set tf [open tahoe.tr w]
$ns trace-all $tf

#creating nam file
set nf [open tahoe.nam w]
$ns namtrace-all $nf

set ft3 [open tahoe_Sender_throughput w]

#finish procedure to call nam and xgraph
proc finish {} {
 global ns nf ft3 
 $ns flush-trace
 #closing all files
 close $nf
 close $ft3
#executing graphs
 exec xgraph tahoe_Sender_throughput &
 puts "running nam..." 
 exec nam tahoe.nam &
#exec awk -f analysis.awk trace1.tr &
 exit 0
}
#record procedure to calculate total bandwidth and throughput
proc record {} {
 global null3 ft3 
 global http1
 set ns [Simulator instance]
 set time 0.1
 set now [$ns now]
 set bw2 [$null3 set bytes_]
 puts $ft3 "$now [expr $bw2/$time*8/1000000]"
 $null3 set bytes_ 0
 $ns at [expr $now+$time] "record"
 }
#creating 10 nodes
for {set i 0} {$i < 6} {incr i} {
 set n($i) [$ns node]
}
#creating duplex links
$ns duplex-link $n(0) $n(1) 10Kb 10ms DropTail
$ns duplex-link $n(0) $n(3) 100Kb 10ms RED
$ns duplex-link $n(1) $n(2) 50Kb 10ms DropTail
$ns duplex-link $n(2) $n(5) 200Kb 10ms RED
$ns duplex-link $n(3) $n(4) 70Kb 10ms DropTail
$ns duplex-link $n(4) $n(5) 100Kb 10ms DropTail

#orienting links
$ns duplex-link-op $n(0) $n(1) orient right
$ns duplex-link-op $n(1) $n(2) orient right-down
$ns duplex-link-op $n(0) $n(3) orient left-down
$ns duplex-link-op $n(3) $n(4) orient right-down
$ns duplex-link-op $n(4) $n(5) orient right
$ns duplex-link-op $n(2) $n(5) orient left-down
 

set tcp3 [new Agent/TCP] 
set null3 [new Agent/TCPSink] 
$ns attach-agent $n(0) $tcp3
$ns attach-agent $n(5) $null3
$ns connect $tcp3 $null3
set http1 [new Application/Traffic/Exponential] 
$http1 attach-agent $tcp3  
 
 
#scheduling events
$ns at 0.5 "record"
$ns at 0.2 "$ns trace-annotate \"Starting HTTP from 0 to 5\""
$ns at 0.2 "$n(0) color \"green\""
$ns at 0.2 "$n(5) color \"green\""
$ns at 0.2 "$http1 start" 
$ns at 3.2 "$http1 stop"  
$ns at 5.0 "finish"
$ns run

