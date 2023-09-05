# Initialize variables
BEGIN {
    group1_sent_bytes = 0
    group2_sent_bytes = 0
    group3_sent_bytes = 0
    group1_received_bytes = 0
    group2_received_bytes = 0
    group3_received_bytes = 0
    start_time = -1
    end_time = -1
}

# Process each line in the trace file
{
    if ($1 == "s") {
        # Sender event
        event_time = $2
        if (start_time < 0 || event_time < start_time) {
            start_time = event_time
        }
        end_time = event_time
        packet_type = $8
        if (packet_type == "cbr") {
            packet_size = $7
            if ($6 == "0.0") {
                group1_sent_bytes += packet_size
            } else if ($6 == "1.0") {
                group2_sent_bytes += packet_size
            } else if ($6 == "8.0") {
                group3_sent_bytes += packet_size
            }
        }
    } else if ($1 == "r") {
        # Receiver event
        event_time = $2
        packet_type = $8
        if (packet_type == "cbr") {
            packet_size = $7
            if ($6 == "0.0") {
                group1_received_bytes += packet_size
            } else if ($6 == "1.0") {
                group2_received_bytes += packet_size
            } else if ($6 == "8.0") {
                group3_received_bytes += packet_size
            }
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
    group1_throughput = (group1_received_bytes / duration) / 1000000  # Convert to Mbps
    group2_throughput = (group2_received_bytes / duration) / 1000000
    group3_throughput = (group3_received_bytes / duration) / 1000000

    printf("Group 1 Throughput: %.2f Mbps\n", group1_throughput)
    printf("Group 2 Throughput: %.2f Mbps\n", group2_throughput)
    printf("Group 3 Throughput: %.2f Mbps\n", group3_throughput)
}

