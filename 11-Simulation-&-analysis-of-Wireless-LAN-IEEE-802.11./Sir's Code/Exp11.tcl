Mac/802_11 set dataRate_ 1Mb
set val(chan) Channel/WirelessChannel ;# channel type
set val(prop) Propagation/TwoRayGround ;# radio-propagation model

set val(ant) Antenna/OmniAntenna ;# Antenna type
set val(ll) LL ;# Link layer type
set val(ifq) Queue/DropTail/PriQueue ;# Interface queue type
set val(ifqlen) 50 ;# max packet in ifq
set val(netif) Phy/WirelessPhy ;# network interface type
set val(mac) Mac/802_11 ;# MAC type
set val(nn) 15 ;# number of mobilenodes
set val(rp) AODV ;# routing protocol
set val(x) 800
set val(y) 800

# Creating simulation object
set ns [new Simulator]

#creating Output trace files
set f [open complexdcf.tr w]
$ns trace-all $f

set namtrace [open complexdcf.nam w]
$ns namtrace-all-wireless $namtrace $val(x) $val(y)

set f0 [open C_DCF_AT.tr w]

set topo [new Topography]
$topo load_flatgrid 800 800
# Defining Global Variables
create-god $val(nn)
set chan_1 [new $val(chan)]
# setting the wireless nodes parameters
$ns node-config -adhocRouting $val(rp) \
-llType $val(ll) \
-macType $val(mac) \
-ifqType $val(ifq) \
-ifqLen $val(ifqlen) \
-antType $val(ant) \
-propType $val(prop) \
-phyType $val(netif) \
-topoInstance $topo \
-agentTrace OFF \
-routerTrace ON \
-macTrace ON \
-movementTrace OFF \
-channel $chan_1 

proc finish {} {
global ns f f0 namtrace# global variables
# Closing the trace files
$ns flush-trace
#close $namtrace
close $f0
exec nam -r 5m complexdcf.nam & # Running the animator
exit 0
}
# Defining a procedure to calculate the througpout
proc record {} {
global sink1 sink3 sink7 sink10 sink11 f0
set ns [Simulator instance]
set time 0.5
set bw0 [$sink3 set bytes_]
set bw3 [$sink3 set bytes_]
set bw7 [$sink7 set bytes_]
set bw10 [$sink10 set bytes_]
set bw11 [$sink11 set bytes_]
set now [$ns now]
puts $f0 "$now [expr ($bw0+$bw3+$bw7+$bw10+$bw11)/$time*8/1000000]"
# Calculating the average throughput

$sink1 set bytes_ 0
$sink3 set bytes_ 0
$sink7 set bytes_ 0
$sink10 set bytes_ 0
$sink11 set bytes_ 0
$ns at [expr $now+$time] "record"
}
#Creating the wireless Nodes
for {set i 0} {$i < $val(nn) } {incr i} {
set n($i) [$ns node]
$n($i) random-motion 0 ;
}
#setting the initial position for the nodes
for {set i 0} {$i < $val(nn)} {incr i} {
$ns initial_node_pos $n($i) 30+i*100
}
for {set i 0} {$i < $val(nn)} {incr i} {
$n($i) set X_ 0.0
$n($i) set Y_ 0.0
$n($i) set Z_ 0.0
}
# making some nodes move in the topography
$ns at 0.0 "$n(0) setdest 100.0 100.0 3000.0"
$ns at 0.0 "$n(1) setdest 200.0 200.0 3000.0"
$ns at 0.0 "$n(2) setdest 300.0 200.0 3000.0"
$ns at 0.0 "$n(3) setdest 400.0 300.0 3000.0"
$ns at 0.0 "$n(4) setdest 500.0 300.0 3000.0"
$ns at 0.0 "$n(5) setdest 600.0 400.0 3000.0"
$ns at 0.0 "$n(6) setdest 600.0 100.0 3000.0"
$ns at 0.0 "$n(7) setdest 600.0 200.0 3000.0"

$ns at 0.0 "$n(8) setdest 600.0 300.0 3000.0"
$ns at 0.0 "$n(9) setdest 600.0 350.0 3000.0"
$ns at 0.0 "$n(10) setdest 700.0 100.0 3000.0"
$ns at 0.0 "$n(11) setdest 700.0 200.0 3000.0"
$ns at 0.0 "$n(12) setdest 700.0 300.0 3000.0"
$ns at 0.0 "$n(13) setdest 700.0 350.0 3000.0"
$ns at 0.0 "$n(14) setdest 700.0 400.0 3000.0"
$ns at 2.0 "$n(5) setdest 100.0 400.0 500.0"
$ns at 1.5 "$n(3) setdest 450.0 150.0 500.0"
$ns at 50.0 "$n(7) setdest 300.0 400.0 500.0"
$ns at 2.0 "$n(10) setdest 200.0 400.0 500.0"
$ns at 2.0 "$n(11) setdest 650.0 400.0 500.0"
#Creating receiving sinks with monitoring ability to monitor the incoming bytes
# LossMonitor objects are a subclass of agent objects that implement a traffic sink.
set sink1 [new Agent/LossMonitor]
set sink3 [new Agent/LossMonitor]
set sink7 [new Agent/LossMonitor]
set sink10 [new Agent/LossMonitor]
set sink11 [new Agent/LossMonitor]
$ns attach-agent $n(1) $sink1
$ns attach-agent $n(3) $sink3
$ns attach-agent $n(7) $sink7
$ns attach-agent $n(10) $sink10
$ns attach-agent $n(11) $sink11
# setting TCP as the transmission protocol over the connections
set tcp0 [new Agent/TCP]
$ns attach-agent $n(0) $tcp0
set tcp2 [new Agent/TCP]
$ns attach-agent $n(2) $tcp2
set tcp4 [new Agent/TCP]

$ns attach-agent $n(4) $tcp4
set tcp5 [new Agent/TCP]
$ns attach-agent $n(5) $tcp5
set tcp9 [new Agent/TCP]
$ns attach-agent $n(9) $tcp9
set tcp13 [new Agent/TCP]
$ns attach-agent $n(13) $tcp13
set tcp6 [new Agent/TCP]
$ns attach-agent $n(6) $tcp6
set tcp14 [new Agent/TCP]
$ns attach-agent $n(14) $tcp14
set tcp8 [new Agent/TCP]
$ns attach-agent $n(8) $tcp8
set tcp12 [new Agent/TCP]
$ns attach-agent $n(12) $tcp12
# Setting FTP connections
set ftp9 [new Application/FTP]
$ftp9 attach-agent $tcp9
$ftp9 set type_ FTP
set ftp13 [new Application/FTP]
$ftp13 attach-agent $tcp13
$ftp13 set type_ FTP
set ftp6 [new Application/FTP]
$ftp6 attach-agent $tcp6
$ftp6 set type_ FTP
set ftp14 [new Application/FTP]
$ftp14 attach-agent $tcp14
$ftp14 set type_ FTP
set ftp8 [new Application/FTP]
$ftp8 attach-agent $tcp8

$ftp8 set type_ FTP
set ftp12 [new Application/FTP]
$ftp12 attach-agent $tcp12
$ftp12 set type_ FTP
#connecting the nodes
$ns connect $tcp0 $sink3
$ns connect $tcp5 $sink3
$ns connect $tcp2 $sink1
$ns connect $tcp4 $sink1
$ns connect $tcp9 $sink7
$ns connect $tcp13 $sink7
$ns connect $tcp6 $sink10
$ns connect $tcp14 $sink10
$ns connect $tcp8 $sink11
$ns connect $tcp12 $sink11
# Defining CBR procedure with the required parametes
proc attach-CBR-traffic { node sink size interval } {
set ns [Simulator instance]
set cbr [new Agent/CBR]
$ns attach-agent $node $cbr
$cbr set packetSize_ $size
$cbr set interval_ $interval
$ns connect $cbr $sink
return $cbr
}
set cbr0 [attach-CBR-traffic $n(0) $sink3 1000 .015]
set cbr1 [attach-CBR-traffic $n(5) $sink3 1000 .015]
set cbr2 [attach-CBR-traffic $n(2) $sink1 1000 .015]
set cbr3 [attach-CBR-traffic $n(4) $sink1 1000 .015]
# Setting the begining and ending time of each connection

$ns at 0.0 "record"
$ns at 20.0 "$cbr0 start"
$ns at 20.0 "$cbr2 start"
$ns at 800.0 "$cbr0 stop"
$ns at 850.0 "$cbr2 stop"
$ns at 30.0 "$cbr1 start"
$ns at 30.0 "$cbr3 start"
$ns at 850.0 "$cbr1 stop"
$ns at 870.0 "$cbr3 stop"
$ns at 25.0 "$ftp6 start"
$ns at 25.0 "$ftp14 start"
$ns at 810.0 "$ftp6 stop"
$ns at 860.0 "$ftp14 stop"
$ns at 35.0 "$ftp9 start"
$ns at 35.0 "$ftp13 start"
$ns at 830.0 "$ftp9 stop"
$ns at 889.0 "$ftp13 stop"
$ns at 40.0 "$ftp8 start"
$ns at 40.0 "$ftp12 start"
$ns at 820.0 "$ftp8 stop"
$ns at 890.0 "$ftp12 stop"
$ns at 900.0 "finish"
# Runnning the simulation
puts "Start of simulation.."
$ns run
