set ns [new Simulator]

set val(chan) Channel/WirelessChannel
set val(prop) Propagation/TwoRayGround
set val(netif) Phy/WirelessPhy
set val(ifqtype) Queue/DropTail/PriQueue
set val(ifqlen) 50
set val(mact) Mac/802_11
set val(ll) LL
set val(ant) Antenna/OmniAntenna
set val(rp) AODV
set val(x) 800
set val(y) 800
set val(nn) 13

set tr [open "output.tr" w]
$ns trace-all $tr

set nam_file [open wan_nam.nam w]
$ns namtrace-all-wireless $nam_file $val(x) $val(y)

set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)

create-god $val(nn)

set chan1 [new $val(chan)]

$ns node-config -adhocRouting $val(rp) \
	        -llType $val(ll) \
	        -phyType $val(netif) \
	        -propType $val(prop) \
	        -ifqType $val(ifqtype) \
	        -ifqLen $val(ifqlen) \
	        -antType $val(ant) \
	        -macType $val(mact) \
	        -topoInstance $topo \
	        -agentTrace ON \
	        -macTrace ON \
	        -routerTrace ON \
	        -movementTrace ON \
	        -channel $chan1

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

$n0 color "pink"
$ns at 0.0 "$n0 color pink"
$n1 color "pink"
$ns at 0.0 "$n1 color pink"
$n2 color "pink"
$ns at 0.0 "$n2 color pink"
$n3 color "pink"
$ns at 0.0 "$n3 color pink"
$n4 color "pink"
$ns at 0.0 "$n4 color pink"
$n5 color "pink"
$ns at 0.0 "$n5 color pink"
$n6 color "pink"
$ns at 0.0 "$n6 color pink"

$n7 color "blue"
$ns at 0.0 "$n7 color blue"
$n8 color "blue"
$ns at 0.0 "$n8 color blue"
$n9 color "blue"
$ns at 0.0 "$n9 color blue"
$n10 color "blue"
$ns at 0.0 "$n10 color blue"
$n11 color "blue"
$ns at 0.0 "$n11 color blue"
$n12 color "blue"
$ns at 0.0 "$n12 color blue"

$ns duplex-link $n6 $n7 0.3Gb 200ms DropTail

$n0 set X_ 40.0
$n0 set Y_ 200.0
$n0 set Z_ 0.0

$n1 set X_ 80.0
$n1 set Y_ 500.0
$n1 set Z_ 0.0

$n2 set X_ 120.0
$n2 set Y_ 230.0
$n2 set Z_ 0.0

$n3 set X_ 120.0
$n3 set Y_ 280.0
$n3 set Z_ 0.0

$n4 set X_ 280.0
$n4 set Y_ 320.0
$n4 set Z_ 0.0

$n5 set X_ 270.0
$n5 set Y_ 120.0
$n5 set Z_ 0.0

$n6 set X_ 300.0
$n6 set Y_ 400.0
$n6 set Z_ 0.0

$n7 set X_ 500.0
$n7 set Y_ 400.0
$n7 set Z_ 0.0

$n8 set X_ 560.0
$n8 set Y_ 400.0
$n8 set Z_ 0.0

$n9 set X_ 590.0
$n9 set Y_ 320.0
$n9 set Z_ 0.0

$n10 set X_ 570.0
$n10 set Y_ 120.0
$n10 set Z_ 0.0

$n11 set X_ 630.0
$n11 set Y_ 320.0
$n11 set Z_ 0.0

$n12 set X_ 610.0
$n12 set Y_ 120.0
$n12 set Z_ 0.0

#Initial positions..

$n0 random-motion 0
$n1 random-motion 0
$n2 random-motion 0
$n3 random-motion 0
$n4 random-motion 0
$n5 random-motion 0
$n6 random-motion 0
$n7 random-motion 0
$n8 random-motion 0
$n9 random-motion 0
$n10 random-motion 0
$n11 random-motion 0
$n12 random-motion 0

#Inital node positions its size
$ns initial_node_pos $n0 30
$ns initial_node_pos $n1 30
$ns initial_node_pos $n2 30
$ns initial_node_pos $n3 30
$ns initial_node_pos $n4 30
$ns initial_node_pos $n5 30
$ns initial_node_pos $n6 30
$ns initial_node_pos $n7 30
$ns initial_node_pos $n8 30
$ns initial_node_pos $n9 30
$ns initial_node_pos $n10 30
$ns initial_node_pos $n11 30
$ns initial_node_pos $n12 30

set tcps1 [new Agent/TCP]
set tcpr1 [new Agent/TCPSink]
set app1 [new Application/FTP]

$app1 attach-agent $tcps1
$ns attach-agent $n1 $tcps1
$ns attach-agent $n8 $tcpr1

$ns connect $tcps1 $tcpr1

proc finish { } {
global ns tr nam_file
$ns flush-trace
close $tr
close $nam_file
exec nam wan_nam.nam &
exit 0
}


$ns at 0.01 "$app1 start"
$ns at 10 "finish"
$ns run
