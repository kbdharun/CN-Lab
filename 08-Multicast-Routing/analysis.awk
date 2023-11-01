# Initialize variables
BEGIN {
  rec = 0
  drp = 0
  sum = 0
  sum1 = 0
}

# Process each line of the trace file
{
  # Check if the line contains a "r" (received) event with packet size 4
  if ($1 == "r" && $4 == 4) {
    rec++
    sum += $6
  }

  # Check if the line contains a "d" (dropped) event with packet size 4
  if ($1 == "d" && $4 == 4) {
    drp++
  }

  # Check if the line contains a packet sent with size 5 and destination address $group1
  if ($2 > 1.00 && $4 == 5) {
    sum1 += $6
  }
}

# Calculate packet delivery ratio
END {
  tot = rec + drp
  if (tot == 0) {
    rat = 0
  } else {
    rat = (rec / tot) * 100
  }

  throughput = (sum * 8) / 1000000
  throughput1 = (sum1 * 8) / 1000000

  printf("\nPackets received: %d\n", rec)
  printf("Packets dropped: %d\n", drp)
  printf("Packets delivery ratio: %.2f%%\n", rat)
  printf("Throughput for UDP: %.2f Mbps\n", throughput)
  printf("Throughput for TCP: %.2f Mbps\n", throughput1)
}
