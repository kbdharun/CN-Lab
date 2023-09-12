BEGIN {
  rec= 0
  drp=0
  tot=0
  rat=0.0
  sum=0
  sum1=0
  throughput=0.0
  throughput1=0.0
}

{
  
  if($1== "r" && $4== 4)
    {
    
      rec++
    }
    
    
   if($1== "d" && $4 ==4 )
     
     {
       drp++
       
     }
     
     
     
     if($2<1.00 && $4==4)
      {
     
          sum=sum+$6
 
      }
 
    if($2<1.00 && $4==5)
      {
     
          sum1=sum1+$6
 
      }
 
 }
 
 
  
END {
   
      tot = rec + drp
      rat = (rec/tot) *100
      throughput= (sum*8)/1000000
      throughput1=(sum1*8)/1000000
       printf(" \n Packets received %d ", rec)
       printf(" \n Packets dropped %d ", drp)
       printf("\n Packets delivery ratio %f",rat)
        printf("\n Throughput for udp is %f",throughput)
         
        printf("\n Throughput for tcp is %f",throughput1)
     }

