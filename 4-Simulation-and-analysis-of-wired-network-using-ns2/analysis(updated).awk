BEGIN {
  rec= 0
  drp=0
  sum=0
  sum1=0
}
{
  if($1== "r" && $4== 4)
    {
      rec++
      sum+=$6
    }

   if($1== "d" && $4 ==4 )
    
     {
       drp++
     }

    if($2>1.00 && $4==5)
      {
      	sum1=sum1+$6
      }
 }

END {
      tot = rec + drp
      if(rat<0){
      	rat = (rec/tot) *100
      }
      else{
	rat++
	rat=(rec/tot)*100
      }

      throughput= (sum*8)/1000000
      throughput1=(sum1*8)/1000000

       printf(" \n Packets received %d ", rec)
       printf(" \n Packets dropped %d ", drp)
       printf("\n Packets delivery ratio %.2f %",rat)
       printf("\n Throughput for udp is %.2f Mbps",throughput)
       printf("\n Throughput for tcp is %.2f Mbps",throughput1)
 }
