# Lab 03: Kafka Streams Simulation

In this lab, you will simulate Kafka stream processing concepts using command-line tools. We'll demonstrate how data flows from an input topic, gets processed, and flows to an output topic.

## Additional Resources

This lab includes two additional files for advanced users:

### 1. `streams-app.py` - Python Kafka Streams Example

A Python script that demonstrates how to build a real Kafka streams application:

```python
from kafka import KafkaConsumer, KafkaProducer

consumer = KafkaConsumer('input-topic', bootstrap_servers='kafka:9092', auto_offset_reset='earliest')
producer = KafkaProducer(bootstrap_servers='kafka:9092')

for message in consumer:
    uppercased = message.value.decode('utf-8').upper()
    producer.send('output-topic', uppercased.encode('utf-8'))
    print(f"Processed: {uppercased}")
```

**Note**: This requires Python and the `kafka-python` library. It's provided as a reference for how real stream processing applications are built.

### 2. `simple-streams.sh` - Automated Stream Processing Script

A bash script that automates the stream processing workflow using Kafka command-line tools:

```bash
#!/bin/bash
# Simple Kafka Streams simulation using command-line tools
# This script reads from input-topic, processes messages, and writes to output-topic

echo "Starting simple stream processor..."
echo "Reading from input-topic, converting to uppercase, and writing to output-topic"
echo "Press Ctrl+C to stop"

# Use kafka-console-consumer to read and process messages
docker exec lab-03-kafka-streams-kafka-1 kafka-console-consumer.sh \
    --topic input-topic \
    --bootstrap-server localhost:9092 \
    --from-beginning | \
while IFS= read -r line; do
    processed=$(echo "$line" | tr '[:lower:]' '[:upper:]')
    echo "Processing: $line -> $processed"

    echo "$processed" | docker exec -i lab-03-kafka-streams-kafka-1 kafka-console-producer.sh \
        --topic output-topic \
        --bootstrap-server localhost:9092
done
```

To use this script: `chmod +x simple-streams.sh && ./simple-streams.sh`

## Steps

### 1. Start Kafka and Zookeeper

Run:

```sh
docker compose up -d
```

### 2. Create Input and Output Topics

```sh
docker exec lab-03-kafka-streams-kafka-1 kafka-topics.sh --create --topic input-topic --bootstrap-server localhost:9092

docker exec lab-03-kafka-streams-kafka-1 kafka-topics.sh --create --topic output-topic --bootstrap-server localhost:9092
```

### 3. Verify Topics Creation

List all topics to confirm both were created:

```sh
docker exec lab-03-kafka-streams-kafka-1 kafka-topics.sh --list --bootstrap-server localhost:9092
```

### 4. Set Up Stream Processing Simulation

We'll simulate stream processing by manually reading from input-topic, processing messages, and writing to output-topic.

**Step A: Start a consumer for the output topic** (in a new terminal):

```sh
docker exec -it lab-03-kafka-streams-kafka-1 kafka-console-consumer.sh --topic output-topic --bootstrap-server localhost:9092 --from-beginning
```

**Step B: In another terminal, send messages to input-topic:**

```sh
echo "hello world" | docker exec -i lab-03-kafka-streams-kafka-1 kafka-console-producer.sh --topic input-topic --bootstrap-server localhost:9092
echo "kafka streams demo" | docker exec -i lab-03-kafka-streams-kafka-1 kafka-console-producer.sh --topic input-topic --bootstrap-server localhost:9092
```

### 5. Manual Stream Processing

**Step A: Read messages from input-topic:**

```sh
docker exec lab-03-kafka-streams-kafka-1 kafka-console-consumer.sh --topic input-topic --bootstrap-server localhost:9092 --from-beginning --max-messages 2
```

**Step B: Process and send to output-topic (simulate uppercase transformation):**

```sh
echo "HELLO WORLD" | docker exec -i lab-03-kafka-streams-kafka-1 kafka-console-producer.sh --topic output-topic --bootstrap-server localhost:9092
echo "KAFKA STREAMS DEMO" | docker exec -i lab-03-kafka-streams-kafka-1 kafka-console-producer.sh --topic output-topic --bootstrap-server localhost:9092
```

### 6. Verify Stream Processing

Check that the processed messages appear in the output-topic consumer (from Step 4A). You should see:

```
HELLO WORLD
KAFKA STREAMS DEMO
```

This demonstrates the core concept of stream processing: data flows from input → processing → output.

### What We Learned

- **Input Topic**: Receives raw messages from producers
- **Stream Processing**: Transforms data (in our case, converting to uppercase)
- **Output Topic**: Contains processed messages for downstream consumers
- **Data Pipeline**: Shows how Kafka enables building data processing pipelines

## Next Steps (Advanced)

After completing the basic lab, try these advanced exercises:

### Option 1: Automated Processing Script

Run the provided shell script to see automated stream processing:

```sh
chmod +x simple-streams.sh
./simple-streams.sh
```

Then in another terminal, send messages to input-topic and watch them get automatically processed.

### Option 2: Python Streams Application

If you have Python and `kafka-python` library installed locally, you can try the real streams application:

```sh
pip install kafka-python
python3 streams-app.py
```

**Note**: You'll need to modify the bootstrap server in `streams-app.py` from `kafka:9092` to `localhost:9092` to run it outside the container.

These advanced options show how real-world stream processing applications are built and deployed.

---

## Clean Up

```sh
docker compose down
```
