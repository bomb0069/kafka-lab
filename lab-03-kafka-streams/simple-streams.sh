#!/bin/bash

# Simple Kafka Streams simulation using command-line tools
# This script reads from input-topic, processes messages, and writes to output-topic

echo "Starting simple stream processor..."
echo "Reading from input-topic, converting to uppercase, and writing to output-topic"
echo "Press Ctrl+C to stop"

# Use kafka-console-consumer to read from input-topic and process messages
docker exec lab-03-kafka-streams-kafka-1 kafka-console-consumer.sh \
    --topic input-topic \
    --bootstrap-server localhost:9092 \
    --from-beginning \
    --property print.key=false \
    --property print.value=true | \
while IFS= read -r line; do
    # Convert to uppercase (simple processing)
    processed=$(echo "$line" | tr '[:lower:]' '[:upper:]')
    echo "Processing: $line -> $processed"
    
    # Send processed message to output-topic
    echo "$processed" | docker exec -i lab-03-kafka-streams-kafka-1 kafka-console-producer.sh \
        --topic output-topic \
        --bootstrap-server localhost:9092
done