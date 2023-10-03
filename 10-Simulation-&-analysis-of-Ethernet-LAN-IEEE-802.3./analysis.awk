BEGIN {
  rec = 0
  drp = 0
  sum = 0
  sum1 = 0
}

{
  if ($1 == "r" && $4 == 4) {
    rec++
    sum += $6
  }

  if ($1 == "d" && $4 == 4) {
    drp++
  }

  if ($2 < 1.00 && $4 == 5) {
    sum1 += $6
  }
}

END {
  tot = rec + drp
  if (tot > 0) {
    rat = (rec / tot) * 100
  } else {
    rat = 0
  }
  throughput = (sum * 8) / 1000000
  throughput1 = (sum1 * 8) / 1000000

  printf("\nPackets received: %d", rec)
  printf("\nPackets dropped: %d", drp)
  printf("\nPackets delivery ratio: %.2f%%", rat)
  printf("\nThroughput for UDP: %.2f Mbps", throughput)
  printf("\nThroughput for TCP: %.2f Mbps", throughput1)
}
