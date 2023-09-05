# Initialize variables
BEGIN {
    group0_sent_packets = 0
    group1_sent_packets = 0
    group0_received_packets = 0
    group1_received_packets = 0
    start_time = -1
    end_time = -1
}

# Process each line in the trace file
{
    if ($1 == "+" && $5 == "cbr" && $6 == "210") {
        event_time = $2
        if (start_time < 0 || event_time < start_time) {
            start_time = event_time
        }
        end_time = event_time
        agent_id = $4
        if (agent_id == "0") {
            group0_sent_packets++
        } else if (agent_id == "1") {
            group1_sent_packets++
        }
    } else if ($1 == "-" && $5 == "cbr" && $6 == "210") {
        event_time = $2
        agent_id = $4
        if (agent_id == "0") {
            group0_received_packets++
        } else if (agent_id == "1") {
            group1_received_packets++
        }
    }
}

# Calculate and print multicast throughput for each group
END {
    if (start_time < 0 || end_time < 0) {
        print "No valid data found in the trace file."
        exit 1
    }

    duration = end_time - start_time
    group0_throughput = (group0_received_packets / duration)
    group1_throughput = (group1_received_packets / duration)

    printf("Group 0 Throughput: %.2f packets/sec\n", group0_throughput)
    printf("Group 1 Throughput: %.2f packets/sec\n", group1_throughput)
}
