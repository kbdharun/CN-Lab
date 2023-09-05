# Initialize variables
BEGIN {
    group0_sent_bits = 0
    group1_sent_bits = 0
    group0_received_bits = 0
    group1_received_bits = 0
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
        agent_id = $3
        packet_size_bits = $10  # Assuming packet size is reported in bits
        if (agent_id == "0") {
            group0_sent_bits += packet_size_bits
        } else if (agent_id == "1") {
            group1_sent_bits += packet_size_bits
        }
    } else if ($1 == "-" && $5 == "cbr" && $6 == "210") {
        event_time = $2
        agent_id = $3
        packet_size_bits = $10  # Assuming packet size is reported in bits
        if (agent_id == "0") {
            group0_received_bits += packet_size_bits
        } else if (agent_id == "1") {
            group1_received_bits += packet_size_bits
        }
    }
}

# Calculate and print multicast throughput for each group in kbps
END {
    if (start_time < 0 || end_time < 0) {
        print "No valid data found in the trace file."
        exit 1
    }

    duration = end_time - start_time
    group0_throughput = (group0_received_bits / duration) / 1000  # Convert to kbps
    group1_throughput = (group1_received_bits / duration) / 1000

    printf("Group 0 Average Throughput: %.2f kbps\n", group0_throughput)
    printf("Group 1 Average Throughput: %.2f kbps\n", group1_throughput)
}

